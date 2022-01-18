class Queues
    require "bundler/setup"
    require "bunny"
    require 'singleton'
    include Singleton
    
    STDOUT.sync = true

    def initialize
        @conn = Bunny.new(:host => "queue")
        @conn.start
        @ch = @conn.create_channel
        @chatQueue  = @ch.queue("create_chat", :auto_delete => true)
        @msgQueue  = @ch.queue("create_msg", :auto_delete => true)
        @msgUpdateQueue  = @ch.queue("update_msg", :auto_delete => true)

        @chat_consumers  = Chat_Consumers.new
        @chat_consumers.create_chat(@chatQueue)


        @msg_consumers  = Message_Consumers.new
        @msg_consumers.create_msg(@msgQueue)

        @msg_consumers.update_msg(@msgUpdateQueue)

    end
    
    def publish(payload, queueName)
        @x  = @ch.default_exchange
        @x.publish(payload, :routing_key => queueName)
    end

end
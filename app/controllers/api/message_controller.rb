class MessageData 
    require 'redis'

    def initialize(chat_number, msg_number, app_token, body)
        @chat_number = chat_number
        @msg_number = msg_number
        @app_token = app_token
        @body = body
     end
     
    attr_accessor :chat_number, :msg_number, :app_token, :body
end
class Api::MessageController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        key = params[:application_token].to_s + params[:chat_number].to_s
        count  = REDIS.incr(key)
        newMessage = MessageData.new(
            params[:chat_number],
            count,
            params[:application_token],
            msg_create_params[:body]
        )

        Queues.instance.publish(Marshal.dump(newMessage), "create_msg")

        render json: {message_number: count}, status: 202
      
    end

    private
        def msg_create_params
            params.require(:msg).permit(:body)
        end
end
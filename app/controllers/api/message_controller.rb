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
    
    def index
        msg = Message.where(["token = :token and chat_number = :chat_number", {token: params[:application_token].to_s, chat_number: params[:chat_number]}])
        if msg
           render json: msg, status: 200
        else 
            render json: {error: "MESSAGES NOT FOUND"}, status: 404
        end
    end
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

    def show 
        render json: {result: Message.search( params[:query], params[:chat_number], params[:application_token] )}
    end

    def update
        newMessage = MessageData.new(
            params[:chat_number],
            params[:query],
            params[:application_token],
            msg_create_params[:body]
        )

        Queues.instance.publish(Marshal.dump(newMessage), "update_msg")
        render json: {"body": msg_create_params[:body]}, status: 202

    end
    private
        def msg_create_params
            params.require(:msg).permit(:body)
        end

end
class ChatData 
    require 'redis'
    @chat_number
    @msgs_count
    @app_token
    def initialize(chat_number, msgs_count, app_token)
        @chat_number = chat_number
        @msgs_count = msgs_count
        @app_token = app_token
     end
     
    attr_accessor :chat_number, :msgs_count, :app_token
end

class Api::ChatsController < ApplicationController

    skip_before_action :verify_authenticity_token
    def create  
        count = REDIS.incr(params[:application_token].to_s)
        newChat  = ChatData.new(count, 0, params[:application_token])
        Queues.instance.publish(Marshal.dump(newChat), "create_chat")
        render json: {chat_number: count}, status: 202

    end

    def show
        chat = Chat.find_by(chat_number: params[:number], application_token: params[:application_token])
        if chat
           render json: chat, status: 200
        else 
            render json: {error: "CHAT NOT FOUND"}, status: 404
        end
    end


end
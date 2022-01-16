class Chat_Consumers 
  def create_chat(queue)
    queue.subscribe do |delivery_info, metadata, payload|
        newPayload =  Marshal.load(payload)
        chat = Chat.new(
            chat_number: newPayload.chat_number,
            msgs_count: newPayload.msgs_count,
            application_token: newPayload.app_token
            )
          chat.save
        end
  end

end

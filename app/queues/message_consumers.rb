class Message_Consumers
def create_msg(queue)
    queue.subscribe do |delivery_info, metadata, payload|
      newPayload =  Marshal.load(payload)
      msg = Message.new(
          chat_number: newPayload.chat_number,
          msg_number: newPayload.msg_number,
          body: newPayload.body,
          token: newPayload.app_token
          )
      if msg.save
        key = newPayload.app_token.to_s + '/' + newPayload.chat_number.to_s
        REDIS.hset("msgs_count", {key => newPayload.msg_number})
      end
      end
  end

  def update_msg(queue)
    queue.subscribe do |delivery_info, metadata, payload|
      newPayload =  Marshal.load(payload)
      msg = Message.find_by(token: newPayload.app_token,  chat_number: newPayload.chat_number, msg_number: newPayload.msg_number)
      msg.update(body: newPayload.body)
       
  end
  end
end
class Message_Consumers
def create_msg(queue)
    queue.subscribe do |delivery_info, metadata, payload|
      newPayload =  Marshal.load(payload)
      msg = Message.new(
          chat_number: newPayload.chat_number,
          msg_number: newPayload.msg_number,
          body: newPayload.body
          )
      msg.save
      end
  end
end
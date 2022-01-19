namespace :jobs do
  task update_counts: :environment do
    chats  = REDIS.hgetall("chat_count")
    msgs  = REDIS.hgetall("msgs_count")
    chats.each do |key, value|
      App.where(["token = :token", {token: key}]).update_all(chat_count: value)
    end
    REDIS.del("chat_count")

    msgs.each do |key, value|
      keys  = key.split('/',-1)
      Chat.where(["application_token = :application_token and chat_number = :chat_number", {application_token: keys[0], chat_number: keys[1]}]).update_all(msgs_count: value)
    end
    REDIS.del("msgs_count")

  end

end

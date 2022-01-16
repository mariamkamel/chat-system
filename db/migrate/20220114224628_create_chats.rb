class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.integer :chat_number
      t.integer :msgs_count
      t.string :application_token

      t.timestamps
    end
  end
end

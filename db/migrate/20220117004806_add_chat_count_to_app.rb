class AddChatCountToApp < ActiveRecord::Migration[5.1]
  def change
    add_column :apps, :chat_count, :integer
  end
end

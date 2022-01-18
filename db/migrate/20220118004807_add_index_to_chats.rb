class AddIndexToChats < ActiveRecord::Migration[5.1]
    def change
        add_index :chats, :application_token
    end
  end
class AddIndexToMessages < ActiveRecord::Migration[5.1]
    def change
        add_index :messages, [:chat_number, :token]
    end
  end
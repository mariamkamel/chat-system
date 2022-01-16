class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :msg_number
      t.integer :chat_number
      t.string :body

      t.timestamps
    end
  end
end

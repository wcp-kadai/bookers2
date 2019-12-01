class CreateChatMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_messages do |t|
      t.text :content
      t.string :room_id
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
  end
end

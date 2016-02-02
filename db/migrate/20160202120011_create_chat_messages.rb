class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.text :content
      t.references :chat
      t.references :author

      t.timestamps null: false
    end
  end
end

class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.references :user
      t.references :participant

      t.timestamps null: false
    end
  end
end

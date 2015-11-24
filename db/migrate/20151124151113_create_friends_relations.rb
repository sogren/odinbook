class CreateFriendsRelations < ActiveRecord::Migration
  def change
    create_table :friends_relations do |t|
    	t.references :user
    	t.references :friend

      t.timestamps null: false
    end
  end
end

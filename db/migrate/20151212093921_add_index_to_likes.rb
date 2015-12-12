class AddIndexToLikes < ActiveRecord::Migration
  def change
  	add_index :likes, [:likeable_id, :likeable_type, :liker_id], unique: true, name: "likes_index"
  	add_index :likes, :liker_id
  end
end

class AddOwnersToModels < ActiveRecord::Migration
  def change
  	change_table :posts do |t|
  		t.references :author
  	end
  	change_table :comments do |t|
  		t.references :author
  	end
  	change_table :likes do |t|
  		t.references :liker
  	end
  end
end

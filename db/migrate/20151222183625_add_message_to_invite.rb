class AddMessageToInvite < ActiveRecord::Migration
  def change
  	change_table :invitations do |t|
  		t.string :message
  	end
  	change_table :posts do |t|
  		t.integer :receiver_id
  	end
  	add_index :posts, :receiver_id
  end
end

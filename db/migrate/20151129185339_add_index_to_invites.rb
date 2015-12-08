class AddIndexToInvites < ActiveRecord::Migration
  def change
  	add_index :invitations, :invited_user_id
  	add_index :invitations, :inviting_user_id
  	add_index :invitations, [:invited_user_id, :inviting_user_id], unique: true
  end
end

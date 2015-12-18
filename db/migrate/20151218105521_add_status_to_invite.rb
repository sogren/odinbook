class AddStatusToInvite < ActiveRecord::Migration
  def change
  	change_table :invitations do |t|
  		t.string :status
  	end
  end
end

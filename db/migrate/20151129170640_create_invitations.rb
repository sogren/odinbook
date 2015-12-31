class CreateInvitations < ActiveRecord::Migration
	def change
		create_table :invitations do |t|
			t.references :invited_user, :inviting_user
			t.timestamps null: false
		end
	end
end

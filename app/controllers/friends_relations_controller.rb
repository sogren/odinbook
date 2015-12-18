class FriendsRelationsController < ApplicationController
	def make_friend
		@inv = current_user.received_invitations.find_by(inviting_user_id: friend_params, status: "pending")
		if @inv
			@inv.update(status: "accepted")
			@friendship = current_user.friends_relations.build(friend_id: friend_params)
			if @friendship.save
				flash[:notice] = "Added as friend!"
				redirect_to people_path
			else
				flash[:danger] = "Unable to add."
				redirect_to people_path
			end
		else
			flash[:danger] = "There is no invitation like this"
			redirect_to people_path
		end
	end

	def destroy
		@friendship = current_user.friends_relations.find_by(friend_id: friend_params) || current_user.inverse_friends_relations.find_by(friend_id: friend_params)
		@inv = current_user.sent_invitations.find_by(invited_user_id: friend_params)
		if @friendship.destroy
			flash[:danger] = "Friend removed."
		else
			flash[:danger] = "Unable to add."
		end
		redirect_to people_path
	end

	private

		def friend_params
			params.require(:friend_id)
		end
end

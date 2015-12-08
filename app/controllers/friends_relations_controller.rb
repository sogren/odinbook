class FriendsRelationsController < ApplicationController
	def create
		@friendship = current_user.friends_relations.build(friend_id: params[:friend_id])
		if @friendship.save
			flash[:notice] = "Added as friend!"
			redirect_to root_path
		else
			flash[:danger] = "Unable to add."
			redirect_to :back
		end
	end

	def destroy
		@friendship = current_user.friends_relations.find(params[:id])
		@friendship.destroy
		flash[:danger] = "Friend removed."
		redirect_to root_path
	end
end

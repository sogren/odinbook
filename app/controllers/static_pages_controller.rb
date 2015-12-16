class StaticPagesController < ApplicationController
	def home
		if user_signed_in?
			@post = Post.new
			@posts = Post.includes(:author, :likes, comments:[:author, :likes]).all
			@users = User.all_except(current_user)
		end
	end 

	def people
		@invited_users = current_user.invited_users
		@invitations = current_user.invited_by
		@friends = current_user.user_friends
		@users = User.all_except(current_user)
	end
end

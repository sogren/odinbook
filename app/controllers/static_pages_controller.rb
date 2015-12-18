class StaticPagesController < ApplicationController
  skip_before_filter :require_login, only: :home
	def home
		if user_signed_in?
			@post = Post.new
			@posts = Post.includes(:author, :likes, comments:[:author, :likes]).all
			@users = User.all_except(current_user)
		end
	end 

	def people
		@sent_invitations = current_user.sent_invitations.where(status: "pending")
		@received_invitations = current_user.received_invitations.where(status: "pending")
		@friends = current_user.user_friends
		@users = User.all_except(current_user)
	end
end

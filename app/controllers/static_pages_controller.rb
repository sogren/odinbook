class StaticPagesController < ApplicationController
  skip_before_filter :require_login, only: :home
	def home
		if user_signed_in?
			@post = Post.new
			@posts = current_user.feed.includes(:author, :likes, comments:[:author, :likes]).all.order(created_at: :desc)
			@users = users
		end
	end 

	def timeline
		if user_signed_in?
			@post = Post.new
			@users = users
		end
		@user = current_user || User.find(params[:id])
		@posts = @user.posts.includes(:author, :likes, comments:[:author, :likes]).all.order(created_at: :desc)
	end 

	def people
		@sent_invitations = current_user.sent_invitations.where(status: "pending")
		@received_invitations = current_user.received_invitations.where(status: "pending")
		@friends = current_user.user_friends
		@users = users
	end

	def error404
		flash[:danger] = "There is no such page or you have no access to it!"
		redirect_to root_path
	end

	private

		def users
			current_user.may_know.limit(6).offset(rand(User.all.length-6-current_user.user_friends.count))
		end
end

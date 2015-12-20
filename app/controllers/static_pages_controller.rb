class StaticPagesController < ApplicationController
  skip_before_filter :require_login, only: :home
	before_action :authorize, only: [:timeline, :friends]
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
		@user = User.find(params[:id]) || current_user
		@posts = @user.posts.includes(:author, :likes, comments:[:author, :likes]).all.order(created_at: :desc)
	end 

	def people
		@sent_invitations = current_user.sent_invitations.where(status: "pending")
		@received_invitations = current_user.received_invitations.where(status: "pending")
		@friends = current_user.user_friends
		@users = users
	end

	def friends
		@user = User.find(params[:id])
		@friends = @user.user_friends
	end

	def error404
		flash[:danger] = "There is no such page or you have no access to it!"
		redirect_to root_path
	end

	private

		def users
			current_user.may_know.includes(:profile).limit(6).offset(rand(User.all.length-6-current_user.user_friends.count))
		end
		
		def authorize
			@user = User.find(params[:id])
			authorization(@user)
		end
end

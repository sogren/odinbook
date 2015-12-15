class StaticPagesController < ApplicationController
	def home
		if user_signed_in?
			@post = Post.new
			@posts = Post.includes(:author, :likes, comments:[:author, :likes]).all
			@users = User.all_except(current_user)
		end
	end 
end

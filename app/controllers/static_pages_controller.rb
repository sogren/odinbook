class StaticPagesController < ApplicationController
	def home
		if user_signed_in?
			redirect_to dashboard_path
		else
			redirect_to welcome_path
		end
	end 

	def dashboard
		@post = Post.new
		@posts = Post.all
		@users = User.all_except(current_user)
	end

	def welcome
	end
end

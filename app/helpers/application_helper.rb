module ApplicationHelper

	def require_login
		unless user_signed_in?
			flash[:danger] = "You cannot go there! First sign in or sign up!"
			redirect_to root_path
		end
	end

	def authorization(user)
		unless authorized(user)
			flash[:danger] = "This page is private!"
			redirect_to root_path
		end
	end

	def authorized(user)
		current_user.is_friend?(user) || current_user == user || user.public?
	end

	def choose_user
		@user ||= current_user
	end

	def mutual_friends(user)
		current_user.user_friends & user.user_friends
	end
end

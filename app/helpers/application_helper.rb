module ApplicationHelper
	def require_login
		return true if user_signed_in?
		flash[:danger] = "You cannot go there! First sign in or sign up!"
		redirect_to root_path
	end

	def authorization(user)
		unless authorized(user)
			flash[:danger] = "This page is private!"
			redirect_to root_path
		end
	end

	def authorized(user)
		if user_signed_in?
			current_user.is_friend?(user) || current_user == user || user.public?
		else
			user.public?
		end
	end

	def mutual_friends(user)
		current_user.user_friends & user.user_friends
	end

	def friend_button(user)
		if current_user.is_friend?(user)
			a = content_tag(:p, "This user is your friend")
			a << content_tag(:p, (link_to "Manage your friends", people_path))
		elsif current_user.is_invited_by?(user)
			a = content_tag(:p, "This user sent you an invitation")
			a << content_tag(:p, (link_to "Manage your invitations", people_path))
		elsif current_user.invited?(user)
			a = content_tag(:p, "You already sent an invitation")
			a << content_tag(:p, (link_to "Manage your invitations", people_path))
		else
			content_tag(:p, (link_to "Send friend request to this user", send_invite_path(inv_user_id: @user), method: "post"))
		end
	end

	def user_liked?(id, type)
		current_user.likes_relations.find_by(likeable_id: id, likeable_type: type)
	end
end

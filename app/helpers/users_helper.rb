module UsersHelper
	def user_name_link(user)
	 if user.public?
		 link_to user.full_name, timeline_path(user.id)
	 else
		 user.full_name
	 end
	end
end

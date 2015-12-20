module ApplicationHelper 
	def choose_user
		@user ||= current_user
	end
end

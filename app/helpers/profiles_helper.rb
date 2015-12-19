module ProfilesHelper
	def profile_info(value)
		if value != nil
			" #{ value }"
		else
			" Not specified"
		end
	end
end

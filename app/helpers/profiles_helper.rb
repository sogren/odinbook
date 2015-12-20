module ProfilesHelper
	def profile_info(value)
		if value != nil && value != ""
			" #{ value }"
		else
			" Not specified"
		end
	end

	def profile_date(value)
		if value != nil && value != ""
			value.to_time.strftime("%d %B %Y")
		else
			" Not specified"
		end
	end
end

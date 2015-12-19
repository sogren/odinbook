class ProfilesController < ApplicationController
	skip_before_filter :require_login, only: :show
	def show
		@user = User.includes(:profile).find(user_params)
		@profile = @user.profile
	end

	def update
		
	end

	private

		def user_params
			params.require(:user_id)
		end
end

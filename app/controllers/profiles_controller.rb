class ProfilesController < ApplicationController
	skip_before_filter :require_login, only: :show
	before_action :authorize, only: [:show]
	def show
		@user = User.includes(:profile).find(user_params)
		@profile = @user.profile
	end

	def edit
		@profile = current_user.profile
	end

	def update
		@profile = current_user.profile
		if @profile.update(update_profile_params)
			flash[:info] = "Succesfully updated!"
		else
			flash[:danger] = "Update failed"
		end
		redirect_to edit_profile_path
	end

	 private

	def user_params
			params.require(:user_id)
		end

	def update_profile_params
			params.require(:profile).permit(:about, "birthday(1i)", "birthday(2i)", "birthday(3i)", :country, :gender, :profession, :education, :private)
		end
end

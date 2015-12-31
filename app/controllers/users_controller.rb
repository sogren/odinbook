class UsersController < ApplicationController
	def show
		@user = User.find(user_params)
	end

	 private

	def user_params
			params.require(:id)
		end
end

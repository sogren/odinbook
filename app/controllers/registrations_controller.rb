class RegistrationsController < Devise::RegistrationsController
	before_filter :configure_sign_up_params
	before_filter :configure_account_update_params
	skip_before_filter :require_login, only: [:create, :new]

	after_filter :create_profile, only: :create


	def create_profile
		if resource.persisted?
    	resource.create_profile(private: true)
    	#OdinMailer.welcome_email(resource).deliver
    end
	end

	 protected

	def configure_sign_up_params
		 devise_parameter_sanitizer.for(:sign_up) << :first_name << :last_name << :avatar
	 end

	def configure_account_update_params
		 devise_parameter_sanitizer.for(:account_update) << :first_name << :last_name << :avatar
	 end
end

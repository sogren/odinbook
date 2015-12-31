class ApplicationController < ActionController::Base
	include ApplicationHelper
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter :require_login

	helper_method :resource_name, :resource, :devise_mapping

	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

	def not_found
		flash[:danger] = "There is no such page or you have no access to it!"
		redirect_to root_path
	end

	unless Rails.application.config.consider_all_requests_local
		rescue_from ActionController::RoutingError, with: :render_404
		rescue_from ActionController::UnknownController, with: :render_404
		rescue_from ::AbstractController::ActionNotFound, with: :render_404
		rescue_from ActiveRecord::RecordNotFound, with: :render_404
	end

	 protected

	def render_404(_exception)
			flash[:danger] = "There is no such page or you have no access to it!"
			redirect_to root_path
		end

		private

	def authorize
			@user ||= User.find(params[:user_id])
			authorization(@user)
		end
end

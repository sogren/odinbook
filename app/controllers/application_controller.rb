class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  before_filter :require_login

  helper_method :resource_name, :resource, :devise_mapping

  expose(:user) { exposure_block }

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

  def new_session_path(scope)
    new_user_session_path
  end

  protected

  def render_404(_exception)
    flash[:danger] = "There is no such page or you have no access to it!"
    redirect_to root_path
  end



  private

  def authorize
    authorization(user)
  end

  # returns specified user for expose depending on params
  def exposure_block
    return User.find(params[:user_id]) if params[:user_id].present?
    return current_user if params[:id].nil?
    User.find(params[:id])
  end

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  # eager loads current user associated relations - solves n+1 query problem for some actions
  def include_social
    def current_user
      @current_user ||= super &&
        User.includes(:inverse_friends, :friends, :invited_by, :invited_users)
        .find(@current_user.id)
    end
  end
end

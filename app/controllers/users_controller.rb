class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:timeline, :friends]
  before_action :authorize, only: [:timeline, :friends]
  before_action :include_social, only: [:all_users, :timeline]

  def all_users
    @users = User.includes(:profile).all
  end

  def timeline
    if user_signed_in?
      @post = Post.new
      @users = take_users
    end
    @posts = user.timeline(params[:page])
    respond_to do |format|
      format.html { render "timeline" }
      format.js   { render partial: "shared/pagination" }
    end
  end

  def people
    @sent_invitations = current_user.sent_invitations.where(status: "pending")
    @received_invitations = current_user.received_invitations.where(status: "pending")
    @friends = current_user.user_friends
    @users = take_users
  end

  def friends
    @friends = user.user_friends
  end

    private

  def take_users
    current_user.may_know
  end

  def authorize
    user = User.find(params[:id])
    authorization(user)
  end
end

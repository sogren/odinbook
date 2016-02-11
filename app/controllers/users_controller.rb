class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:timeline, :friends]
  before_action :authorize, only: [:timeline, :friends]

  def all_users
    @users = User.includes(:profile).all_except(current_user)
  end

  def timeline
    if user_signed_in?
      @post = Post.new
    end
    @posts = user.timeline(params[:page])
    respond_to do |format|
      format.html { render "timeline" }
      format.js   { render partial: "shared/pagination" }
    end
  end

  def people
    @sent_invitations = current_user.sent_invitations.where(status: "pending")
      .includes(:invited_user)
    @received_invitations = current_user.received_invitations.where(status: "pending")
      .includes(:inviting_user)
    @friends = current_user.user_friends
  end

  def friends
    @friends = user.user_friends
  end

    private

  def authorize
    user = User.find(params[:id])
    authorization(user)
  end
end

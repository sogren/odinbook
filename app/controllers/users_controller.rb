class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:timeline, :friends]
  before_action :authorize, only: [:timeline, :friends]

  def all_users
    @users = User.all
  end

  def timeline
    if user_signed_in?
      @post = Post.new
      @users = users
    end
    @posts = user.timeline.includes(:author, :likes, comments: [:author, :likes])
             .all.paginate(page: params[:page]).order(created_at: :desc)
    respond_to do |format|
      format.html { render "timeline" }
      format.js   { render partial: "shared/pagination" }
    end
  end

  def people
    @sent_invitations = current_user.sent_invitations.where(status: "pending")
    @received_invitations = current_user.received_invitations.where(status: "pending")
    @friends = current_user.user_friends
    @users = users
  end

  def friends
    @friends = user.user_friends
  end

    private

  def users
    current_user.may_know.includes(:profile).limit(6).offset(
      rand(User.all.length - 6 - current_user.user_friends.count))
  end

  def authorize
    user = User.find(params[:id])
    authorization(user)
  end
end

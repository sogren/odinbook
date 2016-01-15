class StaticPagesController < ApplicationController
  skip_before_filter :require_login, only: :home
  respond_to :html, :js


  def home
    if user_signed_in?
      @post = Post.new
      @posts = current_user.feed.includes(:author, :likes, comments: [:author, :likes]).all.paginate(page: params[:page]).order(created_at: :desc)
      @users = users
    end
  end

  def error404
    flash[:danger] = "There is no such page or you have no access to it!"
    redirect_to root_path
  end

   private

  def users
    current_user.may_know.includes(:profile).limit(6).offset(rand(User.all.length - 6 - current_user.user_friends.count))
  end
end

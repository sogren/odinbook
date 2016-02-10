class StaticPagesController < ApplicationController
  skip_before_filter :require_login, only: :home

  def home
    if user_signed_in?
      @post = Post.new
      @posts = current_user.feed(params[:page])
      @users = take_users
      respond_to do |format|
        format.html { render "home" }
        format.js   { render partial: "shared/pagination" }
      end
    else
      render "welcome"
    end
  end

  def error404
    flash[:danger] = "There is no such page or you have no access to it!"
    redirect_to root_path
  end

   private

  def take_users
    current_user.may_know.includes(:profile).order("RANDOM()").limit(6)
  end
end

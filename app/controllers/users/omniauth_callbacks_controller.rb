class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :require_login
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      redirect_to root_path
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_path
    end
  end

  def failure
    redirect_to root_path
  end
end
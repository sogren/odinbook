class SessionsController < Devise::SessionsController
  skip_before_filter :require_login, only: [:create, :new]

  expose(:user) { current_user if params[:id].nil? }

end

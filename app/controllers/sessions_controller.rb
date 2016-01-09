class SessionsController < Devise::SessionsController
  skip_before_filter :require_login, only: [:create, :new]

  expose(:user) { exposure_block }

end

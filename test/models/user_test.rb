require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = users(:first)
  	@post = @user.posts.build(:content "kekeke")
  end
  
end

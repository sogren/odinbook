require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
  	@user = users(:tom)
  	@post = @user.posts.build(content: "kekeke")
  end

  test "post valid"  do
  	assert @post.valid?
  end

  test "max post length"  do
  	@post.content = "a"*251
  	assert_not @post.valid?
  end

  test "content presence"  do
  	@post.content = ""
  	assert @post.valid?
  end

  test "author_id present"  do
  	@post.author_id = nil
  	assert_not @post.valid?
  end

end

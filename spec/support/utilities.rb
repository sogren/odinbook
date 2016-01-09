module Signing
  def sign_in(user)
    visit "/users/sign_in"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
  end

  def sign_up(user)
    visit "/users/sign_up"
    fill_in "user_first_name", with: user.first_name
    fill_in "user_last_name", with: user.last_name
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password
    click_button "Sign up"
  end

  def sign_out
    click_link "log out"
  end
end

module ComPosting
  def make_post
  	within("#new_post") do
  		fill_in "post_content", with: "example post"
  	end
  	click_button "Submit"
  end

  def make_comment_on_post
    posts = page.all(".post")
    posts[0].first(:link, "make-comment").click
    within "#new_comment" do
      fill_in "comment_content", with: "example comment"
      click_button "Send"
    end
  end
end

module Liking
  def like_post(post, liker)
  	liker.likes_relations.create(likeable: post)
  end

  def like_post_by_button
    posts = page.all(".post")
    posts[0].first(:link, "like-post").click
  end

  def like_first_comment_by_button
    comments = page.all(".comment")
    comments[0].first(:link, "like-comment").click
  end

  def like_last_comment_by_button
    comments = page.all(".comment")
    comments[-1].first(:link, "like-comment").click
  end
end
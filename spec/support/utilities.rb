def log_in(user)
  visit "/"
  within("#log-in-form") do
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
  end
  click_button "Log in"
end

def make_post
	within("#new_post") do
		fill_in "post_content", with: "example post"
	end
	click_button "Submit"
end

def like_post(post, liker)
	post.likes.create(likeable_id: post.id, likeable_type: "post", liker_id: user.id)
end
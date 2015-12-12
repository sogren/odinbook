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
	liker.likes_relations.create(likeable: post)
end

def like_post_by_button
  posts = page.all(".post")
  posts[0].click_button("Like")
end
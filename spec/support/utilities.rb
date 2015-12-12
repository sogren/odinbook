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

def make_comment
  posts = page.all(".post")
  posts[0].click_button("Comment")
  #wait_for_ajax
  within ".new_comment" do
    fill_in "comment_content", with: "example comment"
    click_button "Send"
  end
end
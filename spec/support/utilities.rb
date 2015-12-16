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
  posts[0].first(:link, "like-post").click
end

def make_comment_on_post
  posts = page.all(".post")
  posts[0].first(:link, "make-comment").click
  #wait_for_ajax
  within "#new_comment" do
    fill_in "comment_content", with: "example comment"
    click_button "Send"
  end
end

def like_first_comment_by_button
  comments = page.all(".comment")
  comments[0].first(:link, "like-comment").click
end

def like_last_comment_by_button
  comments = page.all(".comment")
  comments[-1].first(:link, "like-comment").click
end
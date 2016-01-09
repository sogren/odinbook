require 'rails_helper'

RSpec.describe "User functions", type: :feature do
  include Signing
  include ComPosting
  include Liking

  let(:user) { create :user }

	before do
		@user = FactoryGirl.create :user
		sign_in(@user)
	end

	describe "making post" do
		before do
			sign_out
			sign_in(user)
			make_post
		end

		it "make post" do
			expect(page).to have_content "example post"
		end
		it "add post to user" do
			expect(user.posts.last.content).to eql("example post")
		end
		it "displays post" do
			expect(user.posts.last.content).to eql("example post")
		end
	end

	describe "have like funcitons" do
		before do
			@post = @user.posts.create(content: "example post")
		end
		it "which add like to post" do
			expect { like_post(@post, @user) }.to change { @post.likes.count }.by(1)
		end
		it "which add liked post to user" do
			expect { like_post(@post, @user) }.to change { @user.liked_posts.count }.by(1)
		end
	end

	describe "can make comments on posts", js: true do
		self.use_transactional_fixtures = false
		before do
			make_post
			make_comment_on_post
		end

		it "and comment is added to post" do
			expect { make_comment_on_post }.to change { Post.last.comments.count }.by(1)
		end
		it "and post has this comment" do
			expect(Post.last.comments.first.content).to eql("example comment")
		end
		it "and comment is added to user" do
			expect { make_comment_on_post }.to change { @user.comments.count }.by(1)
		end
		it "and user has this comment" do
			expect(@user.comments.first.content).to eql("example comment")
		end
		it "and comment is displayed" do
			expect(page).to have_content "example comment"
		end
	end
end

require 'rails_helper'

RSpec.describe "User functions", type: :feature do

	it "should recognize mah routes!" do 
		expect(root_path).to  eql("/")
	end

  before do
  	@user = FactoryGirl.create :user
    log_in(@user)
  end
  
  describe "user can" do
    it "log in successfully" do
      expect(page).to have_content 'successfully'
    end
    
    describe "make post which should" do 
      before do
        @post = @user.posts.create(content: "example post")
        make_post
      end

      it "make posts" do 
        expect(page).to have_content "example post"
      end
      it "add post to user" do
        expect(@user.posts.last.content).to eql("example post")
      end
    end

    describe "like post which should" do  
      before do
        @post = @user.posts.create(content: "example post")
        make_post
      end
      it "add like to post" do
        expect(like_post(@post, @user)).to change(@post.likes.count).by(1)
      end
    end
  end
end

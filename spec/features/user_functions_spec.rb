require 'rails_helper'

RSpec.describe "User functions", type: :feature do

	it "should recognize mah routes!" do 
		expect( root_path ).to  eql( "/" )
	end

  before do
  	@user = FactoryGirl.create :user
    log_in( @user )
  end
  
  describe "user" do
    it "log in successfully" do
      expect( page ).to have_content 'successfully'
    end
    
    describe "can make post which should" do 
      before do
        @post = @user.posts.create( content: "example post" )
        make_post
      end

      it "make posts" do 
        expect( page ).to have_content "example post"
      end
      it "add post to user" do
        expect( @user.posts.last.content ).to eql( "example post" )
      end
    end

    describe "have like funcitons" do  
      before do
        @post = @user.posts.create( content: "example post" ) 
      end
      it "which add like to post" do
        expect{ like_post(@post, @user) }.to change{ @post.likes.count }.by(1)
      end
      it "which add liked post to user" do
        expect{ like_post(@post, @user) }.to change{ @user.liked_posts.count }.by(1)
      end
    end

    describe "can click like on posts" do  
      before do 
        make_post
      end
      it "which add liked post to user" do
        expect{ like_post_by_button }.to change{ Post.first.likes.count }.by(1)
      end
      it "which add like to post" do
        expect{ like_post_by_button }.to change{ @user.liked_posts.count }.by(1)
      end
      it "and user has this post liked " do
        like_post_by_button
        expect( @user.liked_posts.last ).to eql(Post.first)
      end
      it "and post have only one like from user " do 
        expect{ 5.times { like_post_by_button } }.to change{ @user.liked_posts.count }.by(1)
      end
    end
  end
end

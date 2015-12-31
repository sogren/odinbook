require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before do
  	@user	= FactoryGirl.create :user
   @user2	= FactoryGirl.create :user
   request.env["HTTP_REFERER"] = "where_i_came_from"
  end

	 describe "GET #show" do
 		context "when logged in" do
 			before do
 				sign_in @user
 			end

 			context "viewing public post" do
 				it "shows post" do
 					create_and_show_post(@user2)
 					expect(response.success?).to be true
 				end
 			end

 			context "viewing private post" do
 				before do
 					make_profile_private(@user2)
 					create_and_show_post(@user2)
 				end
 				it "redirects to root path" do
 					expect(response).to redirect_to(root_path)
 				end
 				it "informs about privacy" do
 					expect(flash[:danger]).to eql("This page is private!")
 				end
 			end

 			context "viewing your own post with private profile" do
 				it "shows post" do
 					make_profile_private(@user)
 					create_and_show_post(@user)
 					expect(response.success?).to be true
 				end
 			end
 		end

 		context "when logged out" do
 			context "viewing public post" do
 				it "shows post" do
 					create_and_show_post(@user2)
 					expect(response.success?).to be true
 				end
 			end

 			context "viewing private post" do
 				before do
 					make_profile_private(@user2)
 					create_and_show_post(@user2)
 				end
 				it "redirects to root path" do
 					expect(response).to redirect_to(root_path)
 				end
 				it "informs about privacy" do
 					expect(flash[:danger]).to eql("This page is private!")
 				end
 			end
 		end
 	end

	 describe "POST #create" do
 		context "on owners timeline" do
 			before do
 				sign_in @user
 				post :create, post: { content: "casual post" }
 			end

 			it "creates post" do
 				expect(Post.count).to eql(1)
 			end
 			it "sends flash with positive response" do
 				expect(flash[:info]).to eql('Post was successfully created.')
 			end
 			it "add post to users timeline" do
 				expect(@user.timeline.count).to eql(1)
 			end
 			it "add post to users feed" do
 				expect(@user.feed.count).to eql(1)
 			end
 		end

 		context "on friends timeline" do
 			before do
 				sign_in @user
 				@user.sent_invitations.create(invited_user_id: @user2.id, status: "pending")
 				@user.friends_relations.create(friend_id: @user2.id)
 				post :create, post: { content: "casual post", receiver_id: @user2.id }
 			end
 			it "creates post" do
 				expect(FriendsRelation.count).to eql(1)
 				expect(@user.is_friend?(@user2)).to eql(true)
 			end

 			it "creates post" do
 				expect(Post.count).to eql(1)
 			end
 			it "sends flash with positive response" do
 				expect(flash[:info]).to eql('Post was successfully created.')
 			end
 			it "add post to users timeline" do
 				expect(@user.timeline.count).to eql(1)
 			end
 			it "add post to friends timeline" do
 				expect(@user2.timeline.count).to eql(1)
 			end
 			it "add post to users feed" do
 				expect(@user.feed.count).to eql(1)
 			end
 			it "add post to friends feed" do
 				expect(@user2.feed.count).to eql(1)
 			end
 		end

 		context "on strangers timeline" do
 			context "with public profile" do
 				before do
 					sign_in @user
 					post :create, post: { content: "casual post", receiver_id: @user2.id }
 				end
 				it "creates post" do
 					expect(Post.count).to eql(1)
 				end
 				it "sends flash with positive response" do
 					expect(flash[:info]).to eql('Post was successfully created.')
 				end
 			end
 			context "with private profile" do
 				before do
 					sign_in @user
 					make_profile_private(@user2)
 					post :create, post: { content: "casual post", receiver_id: @user2.id }
 				end
 				it "does not create post" do
 					expect(Post.count).to eql(0)
 				end
 				it "sends flash with negitve response" do
 					expect(flash[:danger]).to eql('Post creation failed.')
 				end
 			end
 		end
 	end
end

def create_and_show_post(user)
	user.posts.create(content: "casual post")
	get :show, user_id: user.id, id: Post.first
end

def make_profile_private(user)
	user.profile.update(private: true)
end

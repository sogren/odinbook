require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  before do
  	@user	= FactoryGirl.create :user
   @user2	= FactoryGirl.create :user
  end

	 describe "POST #send_invite" do
 		context "with valid attributes" do
 			before do
 				sign_in @user
 				post :send_invite, inv_user_id: @user2.id
 			end

 			it "creates invitation" do
 				expect(Invitation.count).to eql(1)
 			end
 			it "adds invitation to user" do
 				expect(@user.sent_invitations.count).to eql(1)
 			end
 			it "adds invitation to second user" do
 				expect(@user2.received_invitations.count).to eql(1)
 			end
 			it "makes second user invited by first" do
 				expect(@user.invited?(@user2)).to be true
 			end
 			it "makes user to invite second" do
 				expect(@user2.is_invited_by?(@user)).to be true
 			end
 			it "blocks first user from inviting again" do
 				sign_out(@user)
 				sign_in @user2
 				post :send_invite, inv_user_id: @user.id
 				expect(flash[:danger]).to eql("You cannot invite this user!")
 			end
 			it "blocks second user from inviting again" do
 				sign_out(@user2)
 				sign_in @user
 				post :send_invite, inv_user_id: @user2.id
 				expect(flash[:danger]).to eql("You cannot invite this user!")
 			end
 		end
 	end

	 describe "POST #decline_invite" do
 		before do
 			sign_in @user
 			post :send_invite, inv_user_id: @user2.id
 		end

 		context "after decline with valid attributes" do
 			before do
 				sign_out(@user)
 				sign_in @user2
 				post :decline_invite, inv_user_id: @user.id
 			end

 			it "confirms with flash" do
 				expect(flash[:info]).to eql("invitation declined")
 			end
 			it "does not remove invitation" do
 				expect(@user2.received_invitations.count).to eql(1)
 			end
 			it "declines invitation" do
 				expect(@user2.received_invitations.first.status).to eql("declined")
 			end
 			it "block user from inviting again" do
 				sign_out(@user2)
 				sign_in @user
 				post :send_invite, inv_user_id: @user2.id
 				expect(flash[:danger]).to eql("You cannot invite this user!")
 			end
 		end
 	end

	 describe "POST #remove_invite" do
 		before do
 			sign_in @user
 			post :send_invite, inv_user_id: @user2.id
 		end

 		context "after removing invitation" do
 			before do
 				post :remove_invite, inv_user_id: @user2.id
 			end
 			it "removes invitation from user" do
 				expect(@user2.received_invitations.count).to eql(0)
 			end
 			it "removes invitation" do
 				expect(Invitation.count).to eql(0)
 			end
 			it "confirms with flash" do
 				expect(flash[:info]).to eql("invitation removed")
 			end
 		end
 	end
end

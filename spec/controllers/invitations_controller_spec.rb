require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do

  before do
  	@user		= FactoryGirl.create :user
    @user2	= FactoryGirl.create :user
  end

	describe "POST #send_invite" do
		context "with valid attributes" do
			before do
				sign_in @user
				post :send_invite, { inv_user_id: @user2.id }
			end

			it "should create invite" do
				expect(Invitation.count).to eql(1)
			end
			it "user should have invite" do
				expect(@user.sent_invitations.count).to eql(1)
			end
			it "user2 should have invite" do
				expect(@user2.received_invitations.count).to eql(1)
			end
			it "user2 is invited by user" do
				expect(@user.invited?(@user2)).to be true
			end
			it "user invites user2" do
				expect(@user2.is_invited_by?(@user)).to be true
			end
			it "user2 cannot invite user" do
				sign_in @user2
				post :send_invite, { inv_user_id: @user.id }
				expect(flash[:danger]).to be_present
			end
		end
	end

	describe "POST #decline_invite" do
		before do
			sign_in @user
			post :send_invite, { inv_user_id: @user2.id }
		end

		context "after decline with valid attributes" do 
			before do
				sign_in @user2
				post :decline_invite, { inv_user_id: @user.id }
			end
			it "there is positive response" do
				expect(flash[:info]).to be_present
			end
			it "invitation still exists" do
				expect(@user2.received_invitations.count).to eql(1)
			end
			it "invitation is declined" do
				expect(@user2.received_invitations.first.status).to eql("declined")
			end
			it "user cannot invite again" do
				sign_in @user
				post :send_invite, { inv_user_id: @user2.id }
				expect(flash[:danger]).to be_present
			end
		end
	end

	describe "POST #remove_invite" do
		context "with valid attributes" do
			before do
				sign_in @user
				post :decline_invite, { inv_user_id: @user.id }
			end
		end
	end
end
require 'rails_helper'

RSpec.describe FriendsRelationsController, type: :controller do

  before do
  	@user		= FactoryGirl.create :user
    @user2	= FactoryGirl.create :user
  end

	describe "after invitation" do
		before do
			@user.sent_invitations.build(invited_user_id: @user2.id, status: "pending").save
		end
		
		it "user2 have invite" do 
			expect(@user2.received_invitations.count).to eql(1)
		end
		
		it "user2 cannot invite user" do 
			@user2.sent_invitations.build(invited_user_id: @user.id, status: "pending").save
			expect(@user.received_invitations.count).to eql(0)
		end
		
		it "user2 is invited by user" do 
			expect(@user2.is_invited_by?(@user)).to eql(true)
		end
		
		it "user invited user2" do 
			expect(@user.invited?(@user2)).to eql(true)
		end
	end
end

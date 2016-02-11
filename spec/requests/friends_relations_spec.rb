require 'rails_helper'
require 'shared_contexts'

RSpec.describe "FriendsRelations", type: :request do
  include_context "api request authentication helper methods"
  include_context "api request global before and after hooks"

  before do
    @user		= FactoryGirl.create :user
    @user2	= FactoryGirl.create :user
  end

  describe "POST #make_friend" do
    context "with invitation" do
      before do
        send_invitation(@user2, @user)
        make_friends(@user, @user2)
      end
      it "confirms with flash" do
        expect(flash[:notice]).to eql("Added as friend!")
      end
      it "adds friend to user" do
        expect(@user.friends.count).to eql(1)
      end
      it "makes user2 a friend of user" do
        expect(@user.friends.first).to eql(@user2)
      end
      it "changes status of invitation" do
        expect(@user.received_invitations.first.status).to eql("accepted")
      end
      it "prohibits user from sending another invite to user2" do
        send_invitation(@user, @user2)
        expect(@user.sent_invitations.count).to eql(0)
      end
      it "prohibits user from friending user2 again" do
        make_friends(@user, @user2)
        expect(@user.friends.count).to eql(1)
      end
      it "prohibits user2 from inviting user again" do
        send_invitation(@user2, @user)
        expect(@user2.sent_invitations.count).to eql(1)
      end
    end
    context "without invitation" do
      it "sends flash with engative response" do
        make_friends(@user, @user2)
        expect(flash[:danger]).to eql("Unable to make friendship.")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      send_invitation(@user2, @user)
      make_friends(@user, @user2)
    end

    context "when first user removes friend" do
      before do
        remove_friends(@user, @user2)
      end

      it "confirms with flash" do
        expect(flash[:warning]).to eql("Friend removed.")
      end
      it "destroys friends relation" do
        expect(FriendsRelation.count).to eql(0)
      end
      it "removes connected invitation" do
        expect(Invitation.count).to eql(0)
      end
    end

    context "when second user removes friend" do
      before do
        remove_friends(@user2, @user)
      end

      it "confirms with flash" do
        expect(flash[:warning]).to eql("Friend removed.")
      end
      it "destroys friends relation" do
        expect(FriendsRelation.count).to eql(0)
      end
      it "removes connected invitation" do
        expect(Invitation.count).to eql(0)
      end
    end
  end
end

def send_invitation(sender, receiver)
  sign_in sender
  post send_invite_path(id: receiver.id)
  sign_out
end

def make_friends(friender, friend)
  sign_in friender
  post make_friend_path(friend_id: friend.id)
  sign_out
end

def remove_friends(remover, friend)
  sign_in remover
  delete remove_friend_path(friend_id: friend.id)
  sign_out
end

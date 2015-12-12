require 'rails_helper'

RSpec.describe "FriendsRelations", type: :request do 
	describe "#add_friend" do

		before do
			@user = FactoryGirl.create :user
			@user2 = FactoryGirl.create :user

			@friend_rel = @user.friends_relations.build(friend_id: @user2.id).save
		end

		describe "user" do
			it "should do smthing" do
        expect(@user.first_name).to include("John")
      end
		end

		describe "friend_relation" do
			it "to be at both sides" do
				expect(@user.user_friends.count).to eql(1)
				expect(@user2.user_friends.count).to eql(1)
			end
		end

		describe "users" do
			it "to be friends" do
        expect(@user.user_friends.first).to eql(@user2)
        expect(@user2.user_friends.first).to eql(@user)
      end
		end

		describe "friend_relation" do
			it "not to double" do
				@friend_rel2 = @user2.friends_relations.build(friend_id: @user.id).save
				expect(@user.user_friends.count).to eql(1)
				expect(@user2.user_friends.count).to eql(1)
			end 
			it "be only one" do
				@user.friends_relations.build(friend_id: @user2.id).save
				@user.friends_relations.build(friend_id: @user2.id).save
				@user.friends_relations.build(friend_id: @user2.id).save
				expect(@user.user_friends.count).to eql(1)
			end 
		end
	end
end
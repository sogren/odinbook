require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryGirl.create :user }
  let(:user2) { FactoryGirl.create :user }
  let(:users_post) { FactoryGirl.create :post, author: user2 }
  let(:valid_params) {  { content: 'new comment', post_id: users_post.id } }
  let(:inv_params) {  { content: '', post_id: users_post.id } }
  let(:inv_params_wo_post) {  { content: 'new comment', post_id: nil } }

  before do
   request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe 'POST #create' do
    context 'user logged in' do
      before do
        sign_in user
      end

      context 'valid params' do
        before do
          post :create, comment: valid_params
        end

        it 'creates comment' do
          expect(user.comments.count).to eql(1)
        end
        it 'adds comment to post' do
          expect(users_post.comments.count).to eql(1)
        end
        it "sends flash with positive response" do
          expect(flash[:info]).to eql("comment added")
        end
      end

      context 'invalid params with post' do
        before do
          post :create, comment: inv_params
        end

        it 'does not create comment' do
          expect(Comment.count).to eql(0)
        end
        it "sends flash with negative response" do
          expect(flash[:warning]).to eql("adding failed")
        end
      end

      context 'invalid params without post' do
        before do
          post :create, comment: inv_params_wo_post
        end

        it 'does not create comment' do
          expect(Comment.count).to eql(0)
        end
        it "sends flash with negative response" do
          expect(flash[:warning]).to eql("adding failed")
        end
      end
    end
    context 'user logged out' do
      before do
        post :create, comment: valid_params
      end

      it 'redirects to main' do
        expect(response).to redirect_to(root_path)
      end
      it 'does not create comment' do
        expect(Comment.count).to eql(0)
      end
    end
  end
end

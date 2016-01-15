require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  render_views

  let(:user) { FactoryGirl.create :user }
  let(:user2) { FactoryGirl.create :user }
  let(:users_post) { FactoryGirl.create :post, author: user2 }
  let(:users_comment) { FactoryGirl.create :comment, author: user2, post_id: users_post.id }

  before do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe 'POST #create' do
    before do
      sign_in user
    end

    context 'when liking post' do
      before do
        like_post(users_post)
      end

      it 'adds like to post' do
        expect(users_post.likes.count).to eql(1)
      end
      it 'adds post to users liked' do
        expect(user.liked_posts.count).to eql(1)
      end
    end

    context 'when liking comment' do
      before do
        like_comment(users_comment)
      end

      it 'adds like to comment' do
        expect(users_comment.likes.count).to eql(1)
      end
      it 'adds comment to users liked' do
        expect(user.liked_comments.count).to eql(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in user
    end

    context 'when unliking post' do
      before do
        create_post_like_directly(user, users_post)
        unlike_post(users_post)
      end

      it 'destroys like' do
        expect(Like.count).to eql(0)
      end
      it 'removes like from post' do
        expect(users_post.likes.count).to eql(0)
      end
      it 'removes post from user' do
        expect(user.liked_posts.count).to eql(0)
      end
    end

    context 'when unliking comment' do
      before do
        create_comment_like_directly(user, users_comment)
        unlike_comment(users_comment)
      end

      it 'destroys like' do
        expect(Like.count).to eql(0)
      end
      it 'removes like from post' do
        expect(users_comment.likes.count).to eql(0)
      end
      it 'removes post from user' do
        expect(user.liked_comments.count).to eql(0)
      end
    end
  end

  def create_post_like_directly(user, post)
    user.likes_relations.create(likeable_id: post.id, likeable_type: "Post")
  end

  def create_comment_like_directly(user, comment)
    user.likes_relations.create(likeable_id: comment.id, likeable_type: "Comment")
  end

  def like_post(thing)
    post :create, liked: { likeable_id: thing.id, likeable_type: 'Post' }
  end

  def like_comment(thing)
    post :create, liked: { likeable_id: thing.id, likeable_type: 'Comment' }
  end

  def unlike_post(thing)
    delete :destroy, liked: { likeable_id: thing.id, likeable_type: 'Post' }
  end

  def unlike_comment(thing)
    delete :destroy, liked: { likeable_id: thing.id, likeable_type: 'Comment' }
  end
end

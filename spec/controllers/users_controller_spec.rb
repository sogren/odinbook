require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  def setup(action, target, priv = nil, user = nil)
    target.profile.update(private: true) if priv
    if user
      user.sent_invitations.build(invited_user_id: target.id, status: 'pending')
      target.friends_relations.create(friend_id: target.id)
    end
    get action, id: target.id
  end

  let(:user) { create :user }
  let(:user2) { create :user }

  context 'when logged in' do
    before { sign_in user }
    describe 'GET #timeline' do
      context 'on friends timeline-page' do

        context 'with public profile' do
          before { setup(:timeline, user2, nil, user) }
          it { expect(response).to render_template(:timeline) }
        end
        context 'with private profile' do
          before { setup(:timeline, user2, true, user) }
          it { expect(response).to render_template(:timeline) }
        end
      end

      context 'on strangers timeline-page' do

        context 'with public profile' do
          before { setup(:timeline, user2, nil) }
          it { expect(response).to render_template(:timeline) }
        end
        context 'with private profile' do
          before { setup(:timeline, user2, true) }
          it { expect(response).to redirect_to(root_path) }
        end
      end

      context 'on own timeline-page' do

        context 'with public profile' do
          before { setup(:timeline, user, nil) }
          it { expect(response).to render_template(:timeline) }
        end
        context 'with private profile' do
          before { setup(:timeline, user, true) }
          it { expect(response).to render_template(:timeline) }
        end
      end
    end

    describe 'GET #people' do
      context 'on own people-page' do
        before { get :people }
        it { expect(response).to render_template(:people) }
      end
    end

    describe 'GET #friends' do
      context 'on friends friends-page' do

        context 'with public profile' do
          before { setup(:friends, user2, nil, user) }
          it { expect(response).to render_template(:friends) }
        end
        context 'with private profile' do
          before { setup(:friends, user2, true, user) }
          it { expect(response).to render_template(:friends) }
        end
      end

      context 'on strangers friends-page' do

        context 'with public profile' do
          before { setup(:friends, user2, nil) }
          it { expect(response).to render_template(:friends) }
        end
        context 'with private profile' do
          before { setup(:friends, user2, true) }
          it { expect(response).to redirect_to(root_path) }
        end
      end

      context 'on own friends-page' do

        context 'with public profile' do
          before { setup(:friends, user, nil) }
          it { expect(response).to render_template(:friends) }
        end
        context 'with private profile' do
          before { setup(:friends, user, true) }
          it { expect(response).to render_template(:friends) }
        end
      end
    end
  end

  context 'when logged out' do
    describe 'GET #timeline' do
      context 'with public profile' do
        before { setup(:timeline, user2, nil) }
        it { expect(response).to render_template(:timeline) }
      end
      context 'with private profile' do
        before { setup(:timeline, user2, true) }
        it { expect(response).to redirect_to(root_path) }
      end
    end

    describe 'GET #people' do
      before { get :people }
      it { expect(response).to redirect_to(root_path) }
    end

    describe 'GET #friends' do
      context 'with public profile' do
        before { setup(:friends, user2, nil) }
        it { expect(response).to render_template(:friends) }
      end
      context 'with private profile' do
        before { setup(:friends, user2, true) }
        it { expect(response).to redirect_to(root_path) }
      end
    end
  end
end

#  signed in
#    friend
#      private
#      public
#    stranger
#      private
#      public
#    own
#      private
#      public
#  signed out
#    private
#    public
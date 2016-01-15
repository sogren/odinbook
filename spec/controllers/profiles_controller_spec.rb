require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  render_views

  let(:user) { FactoryGirl.create :user }
  let(:user2) { FactoryGirl.create :user }

  before do
    request.env['HTTP_REFERER'] = 'where_i_came_from'
  end

  describe 'GET #show' do
    context 'when logged in' do
      before do
        sign_in user
      end
      context 'when profile is public' do
        before do
          show_public_profile
        end
        it 'show the profile' do
          expect(response).to render_template(:show)
        end
      end

      context 'when profile is private' do
        before do
          show_private_profile
        end
        it 'redirects root path' do
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when profile is private but belongs to a friend' do
        before do
          make_friend(user, user2)
          show_private_profile
        end
        it 'show the profile' do
          expect(response).to render_template(:show)
        end
      end
    end

    context 'when logged out' do
      context 'when profile is public' do
        before do
          show_public_profile
        end
        it 'show the profile' do
          expect(response).to render_template(:show)
        end
      end

      context 'when profile is private' do
        before do
          show_private_profile
        end
        it 'redirects root path' do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:valid_params) { { gender: 'Female', profession: "aergae" } }
    let(:invalid_params) { { gender: 'Hehehehehe' } }

    context 'when user is logged in' do
      context 'with valid params' do
        before(:each) do
          sign_in user
          allow(controller).to receive(:current_user).and_return(user)
          edit_private_profile(valid_params)
        end
        it 'changes profile attributes' do
          expect(user.profile.gender).to eql('Female')
        end
        it 'sends flash with positive response' do
          expect(flash[:info]).to eql('Succesfully updated!')
        end
      end

      context 'with invalid params' do
        before do
          sign_in user
          allow(controller).to receive(:current_user).and_return(user)
          allow(user).to receive(:update_attributes).and_return(false)
          edit_private_profile(invalid_params)
        end
        it 'sends flash with negative response' do
          expect(flash[:danger]).to eql('Update failed')
        end
      end
    end

    context 'when user is logged out' do
      it 'redirects to root page' do
        edit_private_profile(valid_params)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  def make_friend(user, user2)
    user.sent_invitations.create(status: 'pending', invited_user_id: user2.id)
    user.friends_relations.create(friend_id: user2.id)
  end

  def show_public_profile
    get :show, user_id: user2
  end

  def show_private_profile
    user2.profile.update(private: true)
    get :show, user_id: user2
  end

  def edit_private_profile(hash)
    put :update, profile: hash
  end
end

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  let(:user) { create :user }

  describe 'GET #timeline' do
    it 'renders timeline' do
      get :timeline, id: user.id
      expect(response).to render_template(:timeline)
    end
  end

  describe 'GET #people' do
    it 'renders people page' do
      sign_in user
      get :people
      expect(response).to render_template(:people)
    end
  end

  describe 'GET #friends' do
    it 'renders friends page' do
      get :friends, id: user.id
      expect(response).to render_template(:friends)
    end
  end
end

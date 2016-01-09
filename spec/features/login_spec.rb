require 'rails_helper'

RSpec.describe "the signin process", type: :feature do
  include Signing

  let(:user) { create :user }
  let(:user2) { build :user }

  describe '#sign_in' do
    before do
      sign_in(user)
    end

    it 'logs in user' do
      expect(page).to have_content('Signed in successfully.')
    end
  end

  describe '#sign_out' do
    before do
      sign_in(user)
      sign_out
    end

    it 'logs in user' do
      expect(page).to have_content('Signed out successfully.')
    end
  end

  describe '#sign_up' do
    before do
      sign_up(user2)
    end

    it 'sign up user' do
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
    it 'creates new user' do
      expect(User.count).to eql(1)
    end
    it 'creates profile for new user' do
      expect(Profile.count).to eql(1)
      expect(User.first.profile).to eql(Profile.first)
    end
  end
end

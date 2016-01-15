require 'rails_helper'

RSpec.describe "Friending", type: :feature do
  include Signing
  include Inviting
  include Friending

  let(:user) { FactoryGirl.create :user }
  let(:user2) { FactoryGirl.create :user }
  let(:user3) { FactoryGirl.create :user }
  let(:user4) { FactoryGirl.create :user }

  describe 'Sending invitation' do
    before do
      sign_in(user)
      visit user_path(user2)
    end

    context 'before send' do
      it 'page have link to send' do
        expect(page).to have_link('Send friend request to this user')
      end
    end

    context 'after send' do
      before { click_link('Send friend request to this user') }

      it 'displays invitation on people-page' do
        within '#invites-sent' do
          expect(page).to have_content(user2.first_name)
        end
      end
      it 'informs about sent inv on profile' do
        visit user_path(user2)
        expect(page).to have_content('You already sent an invitation')
      end
    end
  end

  describe 'Accepting invitation' do
    before { send_inv(user2, user) }

    context 'before accepting' do
      before { sign_in(user) }

      it 'people-page have accept link' do
        visit people_path
        within '#invites-received' do
          expect(page).to have_css('.glyphicon-ok')
        end
      end
    end

    context 'after accepting' do
      before do
        accept_inv(user)
        sign_in(user)
        visit people_path
      end

      it 'invitaiton is gone' do
        within '#invites-received' do
          expect(page).to_not have_content(user2.first_name)
        end
      end
      it 'friend is on friends list' do
        within '#friends' do
          expect(page).to have_content(user2.first_name)
        end
      end
    end
  end

  describe 'Deleting invitation' do
    before { send_inv(user, user2) }

    context 'before deleting' do
      before { sign_in(user) }

      it 'people-page have delete link' do
        visit people_path
        within '#invites-sent' do
          expect(page).to have_css('.glyphicon-remove')
        end
      end
    end

    context 'after deleting' do
      before do
        delete_inv(user)
        sign_in(user)
        visit people_path
      end

      it 'invitaiton is gone' do
        expect(page).to_not have_content(user2.first_name)
      end
    end
  end

  describe 'Declining invitation' do
    before { send_inv(user2, user) }

    context 'before declining' do
      before { sign_in(user) }

      it 'people-page have decline link' do
        visit people_path
        within '#invites-received' do
          expect(page).to have_css('.glyphicon-remove')
        end
      end
    end

    context 'after declining' do
      before do
        decline_inv(user)
        sign_in(user)
        visit people_path
      end

      it 'invitaiton is gone' do
        expect(page).to_not have_content(user2.first_name)
      end
    end
  end

  describe 'Managing friends' do
    before do
      send_inv(user2, user)
      accept_inv(user)
    end

    context 'before remove' do
      it 'friend is present' do
        sign_in(user)
        visit people_path

        within '#friends' do
          expect(page).to have_content(user2.first_name)
        end
      end
    end

    context 'after remove' do
      it 'removes friend' do
        remove_friend(user)
        sign_in(user)
        visit people_path

        within '#friends' do
          expect(page).to_not have_content(user2.first_name)
        end
      end
    end
  end
end
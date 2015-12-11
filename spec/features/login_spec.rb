require 'rails_helper'

describe "the signin process", :type => :feature do
  before :each do
  		@user = FactoryGirl.create :user
  end

  it "signs me in" do
    visit '/'
    within("#log-in-form") do
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
    end
    click_button 'Log in'
    expect(page).to have_content 'successfully'
  end
end
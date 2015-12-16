require 'rails_helper'

RSpec.describe "Site", type: :feature do

  before do
    @user = FactoryGirl.create :user
    log_in( @user )
    5.times { make_post }
  end

	it "should contain logo" do 
    within("#header") do
      expect( page ).to  have_text( "odinbook" )
    end
	end

  it "should contain link to friends" do 
    within("#header") do
      expect( page ).to  have_selector( "friends" )
    end
  end

  it "should contain link to messages" do 
    within("#header") do
      expect( page ).to  have_selector( "messages" )
    end
  end

  it "should contain posts" do
    posts = page.all(".post")
    expect( posts.length ).to eql(5)
  end
end

require 'rails_helper'

RSpec.describe StaticPagesController, type: :feature do

	it "should recognize mah routes!" do 
		expect(root_path).to  eql("/")
	end

  before do
  	@user = FactoryGirl.create :user
    log_in(@user)
  end
  
  it "should log user" do
    expect(page).to have_content 'successfully'
  end
  
  it "should be logged in" do 
  end
end

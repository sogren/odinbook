require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
	it "should recognize mah routes!" do 
		expect(root_path).to  eql("/")
	end
  	before do
  		@user = FactoryGirl.create :user
  	end
  	
    it "should log user" do
    	log_in(@user)
    end
  	
    it "should be logged in" do 
    end
end

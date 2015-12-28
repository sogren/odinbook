FactoryGirl.define do
	factory :profile do
		user :user
		private false
		birthday DateTime.now
		country ""
		about ""
		gender "Male"
		profession ""
		education ""
	end
end
FactoryGirl.define do
  sequence(:first_name) { |n| "John#{n}" }
  sequence(:last_name) { |n| "Doe#{n}" }
  sequence(:email) { |n| "email#{n}@example.com" }

  factory :user do
    first_name
    last_name
    email
    password "qwerqwer"
    after(:create) do |user|
      FactoryGirl.create(:profile, user: user)
    end
  end
end

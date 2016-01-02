FactoryGirl.define do
  sequence(:content) { "#{('a'..'z').to_a.sample(9).join}" }

  factory :post do
    author :author
    content
  end
end

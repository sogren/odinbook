FactoryGirl.define do
  factory :post do |p|
    p.sequence(:content) { |_n| "#{('a'..'z').to_a.sample(9).join}" }
  end
end

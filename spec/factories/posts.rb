FactoryGirl.define do
  factory :post do |p|
    p.sequence(:content) { |n| "#{('a'..'z').to_a.shuffle[0..8].join}" }
  end
end
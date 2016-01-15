FactoryGirl.define do
  factory :comment do
    author :author
    content
    post_id :post_id
  end
end

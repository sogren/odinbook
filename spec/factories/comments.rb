FactoryGirl.define do
  factory :comment do
    author :author
    content
    if :post_id
      post_id :post_id
    end
  end
end

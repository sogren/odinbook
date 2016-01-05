class Comment < ActiveRecord::Base
	has_many :likes, as: :likeable

	belongs_to :post
	belongs_to :author, class_name: "User"

  validates :post_id, presence: true
  validates :content, presence: true

 self.per_page = 6
end

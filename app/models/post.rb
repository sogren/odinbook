class Post < ActiveRecord::Base
	validates :content, length: { maximum: 250 }
	validates :author_id, presence: true
	belongs_to :author, class_name: "User"
	has_many :likes, as: :likeable
	has_many :comments
end

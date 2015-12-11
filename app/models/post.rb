class Post < ActiveRecord::Base
	default_scope { order("created_at DESC") }
	validates :content, length: { maximum: 250 }
	validates :author_id, presence: true
	belongs_to :author, class_name: "User"
	has_many :likes, as: :likeable
end

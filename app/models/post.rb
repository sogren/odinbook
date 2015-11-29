class Post < ActiveRecord::Base
	validates :content, length: { maximum: 250 }
	validates :author_id, presence: true
	belongs_to :author, class_name: "User"
end

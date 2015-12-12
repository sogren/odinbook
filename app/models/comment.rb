class Comment < ActiveRecord::Base
	has_many :likes, as: :likeable

	belongs_to :commentable, polymorphic: true
	belongs_to :author, class_name: "User"

	has_many :comments, as: :commentable
end

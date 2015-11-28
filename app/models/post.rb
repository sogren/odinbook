class Post < ActiveRecord::Base
	validates :content, length: { maximum: 150 }
	belongs_to :author, class_name: "User"
end

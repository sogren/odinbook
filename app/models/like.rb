class Like < ActiveRecord::Base
	belongs_to :liker, class_name: "User"
	belongs_to :likeable, polymorphic: true
end

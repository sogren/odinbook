class Post < ActiveRecord::Base
	#scope :news_feed, -> { where(current_user.friends.include?(author)) }
	validates :content, length: { maximum: 250 }
	validates :author_id, presence: true
	belongs_to :author, class_name: "User"
	has_many :likes, as: :likeable
	has_many :comments

  self.per_page = 6
  
	def receiver
			User.find_by(id: receiver_id)
	end
end

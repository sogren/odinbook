class FriendsRelation < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, class_name: "User"
	validates :user_id, presence: true
	validates :friend_id, presence: true
	validates_uniqueness_of :user_id, scope: :friend_id
end

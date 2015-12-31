class FriendsRelation < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, class_name: "User"
	validates :user_id, presence: true
	validates :friend_id, presence: true
	validates_uniqueness_of :user_id, scope: :friend_id
	validate :is_friendable?

	def is_friendable?
		a = user.id
		b = friend.id
		one		= Invitation.where("inviting_user_id = #{a} AND invited_user_id = #{b} AND status = 'pending'").any?
		two		= Invitation.where("inviting_user_id = #{b} AND invited_user_id = #{a} AND status = 'pending'").any?
		three	= user_id == friend_id
		four	= FriendsRelation.where("user_id = #{b} AND friend_id = #{a}").empty?
		unless one || two && !three && four
			errors.add(:user, "You can not add this user!")
		end
	end
end

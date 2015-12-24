class Invitation < ActiveRecord::Base
	belongs_to :inviting_user, class_name: "User"
	belongs_to :invited_user, class_name: "User"
	validates :inviting_user_id, presence: true
	validates :invited_user_id, presence: true 
	validates_inclusion_of :status, in: %w( pending accepted declined )
	validates_uniqueness_of :invited_user_id, scope: :inviting_user_id
	validate :is_invitable?, on: :create

	def is_invitable?
		a			= inviting_user_id
		b			= invited_user_id
		ids		= [a, b]
		one		= FriendsRelation.where("user_id IN (#{ids.join(',')}) AND friend_id IN (#{ids.join(',')})").any?
		two		= inviting_user_id == invited_user_id
		three	= Invitation.where("inviting_user_id = #{b} AND invited_user_id = #{a}").any?
		if one || two || three
			errors.add(:inviting_user, "You can not ivite this user!")
		end
	end
end

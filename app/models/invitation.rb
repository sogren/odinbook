class Invitation < ActiveRecord::Base
	belongs_to :inviting_user, class_name: "User"
	belongs_to :invited_user, class_name: "User"
	validates :inviting_user_id, presence: true
	validates :invited_user_id, presence: true 
	validates_inclusion_of :status, in: %w( pending accepted declined )
	validates_uniqueness_of :invited_user_id, scope: :inviting_user_id
end

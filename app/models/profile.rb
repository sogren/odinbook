class Profile < ActiveRecord::Base
	belongs_to :user

	validates :user_id, presence: true
	validates_inclusion_of :private, in: [true, false]
#	validates :birthday
#	validates :country
#	validates :about
#	validates :gender
#	validates :profession
#	validates :education

	validates :gender, inclusion: { in: %w{ male female different }}, allow_nil: true
end

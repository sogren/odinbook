class Profile < ActiveRecord::Base
	belongs_to :user

	validates :user_id, presence: true
	validates :about, length: { maximum: 250 }
	validates :private,	inclusion: { in: [true, false] }
	validates :gender,	inclusion: { in: %w{ male female different }}, allow_nil: true

	def profile_description
		about ? about : " User did not write anything."
	end

	def public?
		!private
	end
end

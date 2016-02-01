class Chat < ActiveRecord::Base
  belongs_to :user
  belongs_to :participant

  validates :user_id, presence: true
  validates :participant_id, presence: true
end

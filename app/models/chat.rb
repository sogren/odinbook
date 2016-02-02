class Chat < ActiveRecord::Base
  belongs_to :user
  belongs_to :participant, class_name: "User"

  has_many :chat_messages, dependent: :destroy

  validates :user_id, presence: true
  validates :participant_id, presence: true
end

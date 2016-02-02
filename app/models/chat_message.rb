class ChatMessage < ActiveRecord::Base
  belongs_to :chat
  belongs_to :author, class_name: "User"

  validates :chat_id, presence: true
  validates :author_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
end

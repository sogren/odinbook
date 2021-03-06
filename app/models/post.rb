class Post < ActiveRecord::Base
  # scope :news_feed, -> { where(current_user.friends.include?(author)) }
  belongs_to :author, class_name: "User"
  has_many :likes, as: :likeable
  has_many :comments

  validate :authorized?, if: "receiver_id"
  validates :content, length: { maximum: 250 }
  validates :author_id, presence: true

  self.per_page = 6

  def authorized?
    unless author.is_friend?(receiver) || receiver.public?
      errors.add(:inviting_user, "You can not ivite this user!")
    end
  end

  def receiver
    User.find_by(id: receiver_id) if receiver_id
  end

  def more_comments(page = 1)
    comments.paginate(page: page)
            .includes(:author, :likes)
  end
end

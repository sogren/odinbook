class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	scope :all_except, ->(user) { where.not(id: user) }
	devise :database_authenticatable, :registerable,
				    :recoverable, :rememberable, :trackable, :validatable

	has_attached_file :avatar, default_url: "digger2.jpg"
	validates_attachment_content_type :avatar, content_type: %r{ \Aimage\/.*\Z }

	validates :first_name, :last_name, :email, presence: true
	validates :email, uniqueness: true
	validates :password, length: { minimum: 8 }, unless: "password.nil?"
	validates :password, presence: true, if: "id.nil?"

	has_many :posts, foreign_key: :author_id, dependent: :destroy
	has_many :comments, foreign_key: :author_id, dependent: :destroy

	has_many :sent_invitations, class_name: "Invitation", foreign_key: "inviting_user_id", dependent: :destroy
	has_many :received_invitations, class_name: "Invitation", foreign_key: "invited_user_id", dependent: :destroy

	has_many :invited_users, through: :sent_invitations, source: :invited_user
	has_many :invited_by, through: :received_invitations, source: :inviting_user

	has_many :friends_relations, dependent: :destroy
	has_many :friends, through: :friends_relations
	has_many :inverse_friends_relations, class_name: "FriendsRelation", foreign_key: "friend_id", dependent: :destroy
	has_many :inverse_friends, through: :inverse_friends_relations, source: :user

	has_many :likes_relations, class_name: "Like", foreign_key: "liker_id", dependent: :destroy
	has_many :liked_posts, through: :likes_relations, source: :likeable, source_type: "Post"
	has_many :liked_comments, through: :likes_relations, source: :likeable, source_type: "Comment"

	has_one :profile, dependent: :destroy

	def user_friends
		(friends.all + inverse_friends.all).uniq
	end

	def is_invited_by?(user)
		invited_by.include?(user)
	end

	def invited?(user)
		invited_users.include?(user)
	end

	def is_friend?(friend)
		user_friends.include?(friend)
	end

	def feed
		friends_ids = user_friends.map(&:id)
		Post.where("author_id IN (#{friends_ids.join(',')}) OR author_id = :user_id OR receiver_id = :user_id", user_id: id)
	end

	def may_know
		friends_ids = user_friends.map(&:id)
		User.where("id NOT IN (#{friends_ids.join(',')}) OR id = :id", id: id)
	end

	def timeline
		Post.where('author_id = :user_id OR receiver_id = :user_id', user_id: id)
	end

	def full_name
		"#{first_name} #{last_name}"
	end

	def public?
		profile.public?
	end
end

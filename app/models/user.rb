class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	scope :all_except, ->(user) { where.not(id: user) }
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable
				 
	validates :first_name, :last_name, :email, presence: true
	validates :email, uniqueness: true
	validates :password, length: { minimum: 8 }, unless: "password.nil?"
	validates :password, presence: true, if: "id.nil?"

	has_many :posts, foreign_key: :author_id

	has_many :sent_invitations, class_name: "Invitation", foreign_key: "inviting_user_id", dependent: :destroy
	has_many :received_invitations, class_name: "Invitation", foreign_key: "invited_user_id", dependent: :destroy

	has_many :invited_users, through: :sent_invitations, source: :invited_user
	has_many :invited_by, through: :received_invitations, source: :inviting_user

	has_many :friends_relations
	has_many :friends, through: :friends_relations

	has_many :inverse_friends_relations, class_name: "FriendsRelation", foreign_key: "friend_id"
	has_many :inverse_friends, through: :inverse_friends_relations, source: :user
	
	def is_friend?(user)
	 	
	end
end

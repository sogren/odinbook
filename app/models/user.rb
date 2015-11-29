class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable
				 
	validates :first_name, :last_name, :email, presence: true
	validates :email, uniqueness: true
	validates :password, length: { minimum: 8 }, unless: "password.nil?"
	validates :password, presence: true, if: "id.nil?"

	has_many :posts, foreign_key: :author_id
end

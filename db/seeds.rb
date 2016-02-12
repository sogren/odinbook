# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def true_or_not
  [true,false].sample
end

def make_post(user)
  post = Faker::Lorem.paragraph(p = 3, s = false, o = 3)
  user.posts.create(content: post) if rand(9) > 1
  make_post(user) if rand(7) > 1
end

def make_comment(user, post)
  comment = Faker::Lorem.paragraph(rand(3), true_or_not, rand(4))
  user.comments.create(content: comment, post: post) if rand(9) > 1
end

def user_data
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email
  password = "qwerqwer"
  { first_name: first_name, last_name: last_name, email: email, password: password }
end

def profile_data
  about = Faker::Lorem.paragraph(2, false, 0)
  country = Faker::Address.country
  profession = Faker::Company.profession
  { private: true_or_not, about: about, country: country, profession: profession }
end

def create_user_with_profile
  u = User.create(user_data)
  u.create_profile(profile_data)
  u
end

def send_invite(user, receiver)
  user.sent_invitations.create(invited_user: receiver, status: "pending")
end

u = User.create(first_name: 'John', last_name: 'Doe',
                email: "email1@example.com", password: "qwerqwer")
u.create_profile(profile_data)
make_post(u)

amazing_number = 50

amazing_number.times do
  user = create_user_with_profile
  make_post(user)
end

User.all.each do |user|
  User.all.each do |receiver|
    send_invite(user, receiver) if rand(3) > 1
  end
end

User.all.each do |user|
  all = user.received_invitations
  all.count.times do |k|
    if rand(2) > 0
      user.friends_relations.create(friend_id: all[k].inviting_user_id)
      all[k].update(status: "accepted")
    end
  end
end

(amazing_number * 3).times do
  User.all.each do |user|
    post = user.user_friends.sample.posts.sample
    make_comment(user, post)
  end
end

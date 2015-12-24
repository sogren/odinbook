# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def word 
 ('a'..'z').to_a.shuffle[rand(4)+1..rand(12)+5].join
end

def sentence 
	arr=[]
	t = rand(16)+3
	t.times do 
		arr << word
	end
	arr.join(" ")
end

amazing_number = 30

amazing_number.times do |i|
		a = User.new(first_name: "John##{i+1}", last_name: "Doe##{i+1}", email: "email#{i+1}@example.com", password: "qwerqwer" )
		a.save
		a.create_profile(private: false, about: sentence)
	if rand(7) > 1
		a.posts.build(content: sentence).save
	end
end

User.all.each_with_index do |i, index|
	(amazing_number-index-1).times do |k|
		if rand(15) > 7
			i.sent_invitations.build(invited_user: User.find(2+k),status: "pending").save
		end
	end
end

User.all.each_with_index do |i|
	all = i.received_invitations
	all.count.times do |k|
		if rand(12) > 3
			i.friends_relations.build(friend_id: all[k].inviting_user_id).save
			all[k].update(status: "accepted")
		end
	end
end

(amazing_number*4).times do |i|
	if rand(9) > 1
		a = User.find(rand(amazing_number)+1)
		bb = a.user_friends.map(&:posts).flatten
		b = bb[rand(bb.count)]
		a.comments.build(content: sentence, post: b).save
	end
end

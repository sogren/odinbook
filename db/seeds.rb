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

10.times do |i|
	a = User.new(first_name: "John##{i+1}", last_name: "Doe##{i+1}", email: "email#{i+1}@example.com", password: "qwerqwer" )
	a.save
	a.posts.build(content: sentence).save
end

100.times do |i|
	a = User.find(rand(10)+1)
	b = Post.find(rand(10)+1)
	a.comments.build(content: sentence, post: b).save
end

User.all.each_with_index do |i, index|
	(10-index-1).times do |k|
		if rand(4) > 1
			i.sent_invitations.build(friend_id: User.find(10-k)).save
		end
	end
end

User.all.each_with_index do |i, index|
	(10-index-1).times do |k|
		if rand(4) > 1
			i.sent_invitations.build(friend_id: User.find(10-k)).save
		end
	end
end
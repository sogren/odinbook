# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |i|
	a = User.new(first_name: "#{i}", last_name: "#{i}", email: "email#{i}@example.com", password: "qwerqwer" )
	a.save
	a.posts.build(content: "#{('a'..'z').to_a.shuffle[0..8].join}").save
end
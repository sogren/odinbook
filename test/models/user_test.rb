require 'test_helper'  
class UserTest < ActiveSupport::TestCase
	def setup
		@first = users(:tom)
		@first.posts.build(content: "keke").save
	end

	test "first_name presence" do
		@first.first_name = ""
		assert_not @first.valid?
	end

	test "last_name presence" do
		@first.last_name = ""
		assert_not @first.valid?
	end

	test "email presence" do
		@first.email = ""
		assert_not @first.valid?
	end

	test "has posts" do 
		assert_equal 1, @first.posts.count
	end

	test "posts creation" do
		@first.posts.build(content: "keke").save
		assert_difference("@first.posts.count") do
			@first.posts.build(content: "keke").save
		end
	end
end
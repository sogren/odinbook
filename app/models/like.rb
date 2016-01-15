class Like < ActiveRecord::Base
  belongs_to :liker, class_name: "User"
  belongs_to :likeable, polymorphic: true

  validates_uniqueness_of :liker_id, scope: [:likeable_type, :likeable_id]

  def likes
    likeable.likes.length
  end

end

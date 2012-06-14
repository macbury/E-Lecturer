
class Friendship < ActiveRecord::Base
  belongs_to :user #lecturer
  belongs_to :friend, class_name: "User" # student

  attr_accessor :access_token

  validates_with FriendshipValidator
end

class Friendship < ActiveRecord::Base
  include Amistad::FriendshipModel
  attr_accessible :user_id, :friend_id, :access_token
  attr_accessor   :access_token
  validates_with  FriendshipValidator
end

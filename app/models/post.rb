class Post < ActiveRecord::Base
  has_one :stream, as: :streamable
  attr_accessible :body
end

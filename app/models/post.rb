class Post < ActiveRecord::Base
  has_one         :stream, as: :streamable, dependent: :destroy
  has_many        :comments, dependent: :destroy, as: :commentable
  belongs_to      :user
  attr_accessible :body
  validates       :body, length: { within: 3..2024 }

  def decorator
    @decorator ||= PostDecorator.new(self)
  end

end

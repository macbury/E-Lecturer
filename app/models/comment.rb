class Comment < ActiveRecord::Base
  belongs_to       :commentable,   polymorphic: true
  belongs_to       :user
  attr_accessible  :body
  validates        :body, length: { within: 3..2024 }, presence: true

  def decorator
    @decorator ||= CommentDecorator.new(self)
  end
end

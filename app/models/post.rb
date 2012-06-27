class Post < ActiveRecord::Base
  has_one         :stream, 	as: :streamable, dependent: :destroy
  has_many        :comments, dependent: :destroy, as: :commentable
  has_many        :observers, dependent: :delete_all, as: :observable
  belongs_to      :user
  attr_accessible :body
  validates       :body, length: { within: 3..2024 }, presence: true

  def decorator
    @decorator ||= PostDecorator.new(self)
  end

end

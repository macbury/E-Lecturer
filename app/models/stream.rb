class Stream < ActiveRecord::Base
  belongs_to :streamable,   polymorphic: true
  belongs_to :lecturer,     class_name: "User"

  def decorator
    @decorator ||= StreamDecorator.new(self)
  end
end

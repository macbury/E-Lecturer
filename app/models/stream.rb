class Stream < ActiveRecord::Base
  #attr_accessible :lecturer_id, :streamable_id, :streamable_type, :user_id
  belongs_to :streamable,   polymorphic: true
  belongs_to :lecturer,     class_name: "User"

  def decorator
    @decorator ||= StreamDecorator.new(self)
  end
end

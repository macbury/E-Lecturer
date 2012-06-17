class StreamDecorator < ApplicationDecorator
  decorates :stream

  def lecturer
    model.lecturer.decorator.profile_link
  end
end
class StreamDecorator < ApplicationDecorator
  decorates :stream

  def lecturer
    model.lecturer.decorator.profile_link
  end

  def html
    h.with_format :html do
      h.render partial: model.streamable, locals: { stream: model }, formats: [:html]
    end
  end
end
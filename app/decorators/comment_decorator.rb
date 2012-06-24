class CommentDecorator < ApplicationDecorator
  decorates :comment

  def created_at
    h.time_tag model.created_at, h.distance_of_time_in_words_to_now(model.created_at), class: "have_tooltip", title: I18n.l(model.created_at, format: :long)
  end

  def body
    h.simple_format model.body
  end

  def html
    h.with_format :html do
      h.render partial: model, formats: [:html]
    end
  end
end
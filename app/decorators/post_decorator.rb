class PostDecorator < ApplicationDecorator
  decorates :post
  def body
    h.simple_format h.auto_link(model.body, html: { target: "_blank" })
  end

  def created_at
    h.time_tag model.created_at, h.distance_of_time_in_words_to_now(model.created_at), class: "have_tooltip", title: I18n.l(model.created_at, format: :long)
  end

  def author
    model.user.decorator.profile_link    
  end


end
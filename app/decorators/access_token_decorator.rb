class AccessTokenDecorator < ApplicationDecorator
  decorates :access_token


  def expire_at
    if model.expired?
      I18n.t("simple_form.labels.access_token.expired")
    else
      I18n.l(model.expire_at, format: :long) + " (#{h.distance_of_time_in_words_to_now(model.expire_at)})"
    end
  end

  def created_at
    I18n.l(model.created_at, format: :long)
  end
end
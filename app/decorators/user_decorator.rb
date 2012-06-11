class UserDecorator < ApplicationDecorator
  decorates :user

  def birth_date
    if model.birth_date.nil?
      return "Brak"
    else
      I18n.l(model.birth_date, format: :long)
    end
  end

  def university
    if model.university.nil? || model.university.empty?
      "Brak"
    else
      model.university
    end
    
  end

  def phone
    if model.phone.nil? || model.phone.empty?
      "Brak"
    else
      model.phone
    end
  end

  def about
    if model.about.nil? || model.about.empty?
      "Brak"
    else
      Sanitize.clean(model.about.html_safe, Sanitize::Config::RELAXED).html_safe
    end 
  end

  def titles
    title_array = model.titles.pluck(:name)
    if title_array.empty?
      "Brak"
    else
      title_array.join(", ")
    end
  end

  def profile_path
    h.profile_page_path(screen_name: model.screen_name)
  end

end
class UserDecorator < ApplicationDecorator
  decorates :user

  def full_name
    name = [model.first_name, model.last_name].compact.reject(&:empty?)
    if name.empty?
      name = model.username
    else
      name = name.join(" ") + " (#{model.username})"
    end

  end

  def new_friendship_path(options={})
    options[:screen_name] = model.username
    h.new_friendship_path(options)
  end

  def profile_link
    if model.lecturer?
      h.link_to full_name, profile_path
    else
      h.link_to full_name, h.root_url
    end
  end

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
    if model.lecturer?
      h.profile_page_path(screen_name: model.screen_name)
    else
      h.root_url
    end
  end

  def timeline_path
    h.timeline_path(screen_name: model.screen_name)
  end

  def information_path
    h.information_path(screen_name: model.screen_name)
  end
end
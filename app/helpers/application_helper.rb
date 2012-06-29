module ApplicationHelper
  def with_format(format, &block)
    old_formats = formats
    self.formats = [format]
    result = block.call
    self.formats = old_formats
    result
  end

  def notifications_dropdown
    output = Rails.cache.read("user.#{self.current_user.id}.notifications_html")

    if output.nil?
      output = []
      if current_user.decorator.notifications.empty?
        output << link_to("Brak powiadomien", '#')
      else
        current_user.decorator.notifications.each do |notification|
          output << content_tag(:li, render(partial: "notifications/#{notification.notifiable_type.downcase}", locals: { notification: notification }))
        end
      end

      Rails.cache.write("user.#{self.current_user.id}.notifications_html", output)
    end
    output.join("").html_safe
  end
end

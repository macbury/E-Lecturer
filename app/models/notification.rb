class Notification < ActiveRecord::Base
  attr_accessible :action_key, :message
  belongs_to      :user
  belongs_to      :notifiable, polymorphic: true

  after_create    :expire_notification_cache

  def expire_notification_cache
    Rails.cache.write("user.#{self.user.id}.notifications_html", nil)
  end
end

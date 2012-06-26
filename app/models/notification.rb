class Notification < ActiveRecord::Base
  attr_accessible :action_key, :message
  belongs_to      :user
  belongs_to      :notifiable, polymorphic: true
end

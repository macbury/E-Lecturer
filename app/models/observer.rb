class Observer < ActiveRecord::Base
  belongs_to    :user
  belongs_to    :observable, polymorphic: true
end

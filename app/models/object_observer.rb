class ObjectObserver < ActiveRecord::Observer
  observe :post

  def after_create(record)
  	Rails.logger.debug "After create for object observer"
    record.user.observe!(record)
  end
end

class ObjectObserver < ActiveRecord::Observer
  observe :post

  def after_create(record)
    record.user.observe!(record)
  end
end

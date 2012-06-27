class CthulhuObserver < ActiveRecord::Observer
  observe :post, :comment

  def after_create(record)
    Resque.enqueue(CthulhuWorker, record.class.to_s, record.id, "create")
  end
end
class CthulhuWorker
  @queue = :notifications

  def self.perform(record_class, record_id, action)
    record = record_class.classify.constantize.find(record_id)
    Rails.logger.debug "Sending notification about observation to user for #{record_class} with #{record_id}"
    if record.respond_to?(:commentable) # jest komentarzem
      user_ids = record.commentable.observers.pluck(:user_id)
      user_ids << record.commentable.stream.lecturer_id
    else # inne obiekty w szumie(posty, pliki itp)
      user_ids = record.stream.lecturer.friends.map(&:id)
      user_ids << record.stream.lecturer_id
    end

    user_ids.uniq!
    user_ids.delete(record.user_id)

    User.where(id: user_ids).find_in_batches batch_size: 100 do |users|
      Rails.logger.debug "Creating notifications for #{users.size} users"
      users.each do |user|
        notification            = user.notifications.new
        notification.notifiable = record
        notification.action_key = action
        notification.save
      end
    end
  end
end
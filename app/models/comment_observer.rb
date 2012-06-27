class CommentObserver < ActiveRecord::Observer

  def after_create(comment)
  	Rails.logger.debug "After create for comment observer"
    comment.user.observe!(comment.commentable)
  end

end

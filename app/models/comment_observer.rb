class CommentObserver < ActiveRecord::Observer

  def after_create(comment)
    comment.user.observe!(comment.commentable)
  end

end

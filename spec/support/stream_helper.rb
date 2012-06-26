module StreamHelper
  
  def post_on_lecturer_wall_as!(lecturer, author)
    post = FactoryGirl.build(:post)
    post.user = author
    post.save
    lecturer.posts << post
    post.reload
  end

  def post_on_lecturer_wall!(lecturer)
    post_on_lecturer_wall_as!(lecturer, controller.current_user)
  end

  def create_stream_object!(klass, lecturer)
    self.send("#{klass}_on_lecturer_wall!", lecturer)
  end

  def add_comment_to_object!(object, author)
    comment = object.comments.build(FactoryGirl.attributes_for(:comment))
    comment.user = author
    comment.save!

    comment
  end

end
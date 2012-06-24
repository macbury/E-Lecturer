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

end
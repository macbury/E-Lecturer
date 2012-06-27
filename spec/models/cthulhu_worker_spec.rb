require 'spec_helper'

describe CthulhuWorker do

  it "should create notification for lecturer and its students if student posted on his wall" do
    lecturer  = lecturer_with_observing_students!
    author    = lecturer.friends.first
    post      = post_on_lecturer_wall_as!(lecturer, author)

    CthulhuWorker.perform(post.class.to_s, post.id, "create")
    
    lecturer.friends.each do |student|
      if student == author
        student.notifications.count.should eq(0)
      else
        student.notifications.count.should eq(1)
      end
    end
    lecturer.reload.notifications.count.should eq(1)
  end

  it "should create notification for students if lecturer posted on his wall" do
    lecturer  = lecturer_with_observing_students!
    post      = post_on_lecturer_wall_as!(lecturer, lecturer)

    CthulhuWorker.perform(post.class.to_s, post.id, "create")
    
    lecturer.friends.each do |student|
      student.notifications.count.should eq(1)
    end
    lecturer.reload.notifications.count.should eq(0)
  end

  it "should create notification for lecturer and commenting students for comment in post created by student" do
    lecturer    = lecturer_with_observing_students!
    author      = lecturer.friends.first

    post        = post_on_lecturer_wall_as!(lecturer, author)
    commenters  = lecturer.friends[0..2]
    commenters.each do |commenter|
      comment     = add_comment_to_object!(post, commenter)
      CthulhuWorker.perform(comment.class.to_s, comment.id, "create")
    end
    
    commenters.each_with_index do |student, index|
      student.notifications.count.should eq(commenters.size - index-1)
    end

    (lecturer.friends - commenters).each do |student|
      student.notifications.count.should eq(0)
    end

    lecturer.reload.notifications.count.should eq(3)
  end

  it "should create notification for commenting students for comment in post created by lecturer" do
    lecturer    = lecturer_with_observing_students!
    author      = lecturer.friends.first

    post        = post_on_lecturer_wall_as!(lecturer, lecturer)
    commenters  = lecturer.friends[0..2]
    commenters.each do |commenter|
      comment     = add_comment_to_object!(post, commenter)
      CthulhuWorker.perform(comment.class.to_s, comment.id, "create")
    end
    
    commenters.each_with_index do |student, index|
      student.notifications.count.should eq(commenters.size - index-1)
    end

    (lecturer.friends - commenters).each do |student|
      student.notifications.count.should eq(0)
    end

    lecturer.reload.notifications.count.should eq(3)
  end


end

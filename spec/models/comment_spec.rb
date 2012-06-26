require 'spec_helper'

describe Comment do
  it { should validate_presence_of(:body) }

  it "should start unique observing after creatng a comment for parent post by student" do
    author    = create(:user)
    lecturer  = create(:lecturer)

    post      = post_on_lecturer_wall_as!(lecturer, author)
    comment   = add_comment_to_object!(post, author)

    author.observers.count.should eq(1)

    comment   = add_comment_to_object!(post, author)
    author.observers.count.should eq(1)
  end

  it "should start unique observing after creatng a comment for parent post by lecturer" do
    lecturer  = create(:lecturer)

    post      = post_on_lecturer_wall_as!(lecturer, lecturer)
    comment   = add_comment_to_object!(post, lecturer)

    lecturer.observers.count.should eq(1)

    comment   = add_comment_to_object!(post, lecturer)
    lecturer.observers.count.should eq(1)
  end

end

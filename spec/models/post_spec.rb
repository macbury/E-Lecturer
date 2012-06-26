require 'spec_helper'

describe Post do
  it { should validate_presence_of(:body) }

  it "should start unique observing after creatng a post by student on lecturer" do
    author    = create(:user)
    lecturer  = create(:lecturer)

    post      = post_on_lecturer_wall_as!(lecturer, author)

    author.observers.count.should eq(1)
  end

  it "should start unique observing after creatng a post by lecturer" do
    lecturer  = create(:lecturer)
    post      = post_on_lecturer_wall_as!(lecturer, lecturer)

    lecturer.observers.count.should eq(1)
  end
end

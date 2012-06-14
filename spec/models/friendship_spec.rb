require 'spec_helper'

describe Friendship do
  it { should belong_to(:user) }
  it { should belong_to(:friend) }
 
  it "should be valid for proper configuration" do
    student  = create(:user)
    lecturer = create(:lecturer)

    lecturer.access_tokens.create FactoryGirl.attributes_for(:access_token_for_form)

    friendship = lecturer.friendships.new
    friendship.friend = student
    friendship.access_token = lecturer.access_tokens.first.code
    friendship.valid?.should be(true)  

    friendship.errors[:user_id].should be_empty
    friendship.errors[:friend_id].should be_empty
  end

  it "should be expired for proper configuration" do
    student  = create(:user)
    lecturer = create(:lecturer)

    lecturer.access_tokens.create FactoryGirl.attributes_for(:access_token_for_form)

    access_token = lecturer.access_tokens.first
    access_token.expire_at = 2.days.ago
    access_token.save

    friendship = lecturer.friendships.new
    friendship.friend = student
    friendship.access_token = access_token.code
    friendship.valid?.should be(false)  

    friendship.errors[:user_id].should be_empty
    friendship.errors[:friend_id].should be_empty
    friendship.errors[:access_token].should_not be_empty
  end

  it "show errors for invalid" do
    student  = create(:user)
    lecturer = create(:lecturer)

    lecturer.access_tokens.create FactoryGirl.attributes_for(:access_token_for_form)

    friendship = student.friendships.new
    friendship.friend = lecturer

    friendship.valid?.should be(false)  
    friendship.errors[:user_id].should_not be_empty
    friendship.errors[:friend_id].should_not be_empty
    friendship.errors[:access_token].should_not be_empty
  end
end

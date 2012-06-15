require 'spec_helper'

describe Friendship do
  it { should belong_to(:user) }
  it { should belong_to(:friend) }
 
  it "should be valid for proper configuration" do
    student  = create(:user)
    lecturer = create(:lecturer)

    lecturer.access_tokens.create FactoryGirl.attributes_for(:access_token_for_form)

    friendship = student.connect_with!(lecturer, access_token: lecturer.access_tokens.first.code)
    friendship.valid?.should be(true)  

    friendship.errors[:user_id].should   be_empty
    friendship.errors[:friend_id].should be_empty

    student.reload.friend_with?(lecturer.reload).should be(true)
  end

  it "should not allow to invite second time" do
    student  = create(:user)
    lecturer = create(:lecturer)

    lecturer.access_tokens.create FactoryGirl.attributes_for(:access_token_for_form)

    first_friendship = student.connect_with!(lecturer, access_token: lecturer.access_tokens.first.code)
    first_friendship.valid?.should be(true)  

    student.connect_with!(lecturer, access_token: lecturer.access_tokens.first.code).should be(false)
    student.friend_with?(lecturer).should be(true)
  end

  it "show error for expired access token" do
    student  = create(:user)
    lecturer = create(:lecturer)

    access_token = lecturer.access_tokens.create FactoryGirl.attributes_for(:access_token_for_form)
    access_token.expire_at = 3.months.ago
    access_token.save

    friendship = student.connect_with!(lecturer, access_token: access_token.code)
    friendship.valid?.should be(false) 
    friendship.errors[:access_token].should_not be_empty
    student.friend_with?(lecturer).should be(false)
  end
end

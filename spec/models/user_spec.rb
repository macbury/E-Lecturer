# encoding: UTF-8
require 'spec_helper'

describe User do
  it { should have_and_belong_to_many(:titles) }
  it { should have_many(:friends).through(:friendships) }
  
  it "should not allow to change mode through mass assigment" do
    User.new.new?.should be(true)
  end

  it "should be valid for undefined user" do
    user = build(:user)
    user.new?.should   be(true)
    user.valid?.should be(true)

    user.mode = User::Lecturer
    user.valid?.should be(false)
  end

  it "should be valid for lecturer user" do
    user = build(:lecturer)
    user.valid?.should be(true)
    user.screen_name = "$%^& *(("
    user.valid?.should be(false)

    user.errors[:screen_name].should_not be_nil
    user.screen_name = "elvis.presley"
    user.valid?.should be(true)
  end

  { '' => false, "elvis.presley" => true, "test1234" => true, 'programowanie jest fajne' => false, 'śćółń' => false, 'ss' => false, '12345678912345678912345678' => false }.each do |sn, test|
    it "should return #{test.inspect} for #{sn.inspect} in screen_name" do
      user = build(:lecturer)
      user.screen_name = sn
      user.valid?.should be(test)
      if test
        user.errors[:screen_name].should eq([])
      else
        user.errors[:screen_name].should_not eq([])
      end
    end
  end
end

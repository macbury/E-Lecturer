# encoding: UTF-8
require 'spec_helper'

describe User do
  it { should have_and_belong_to_many(:titles) }
  it { should have_many(:friends).through(:friendships) }
  
  it "should not allow to change mode through mass assigment" do
    User.new.new?.should be(true)
  end

  it "should allow setup username on create" do
    user = build(:user)
    username = user.username
    user.save
    user.username.should == username
    user.update_attributes username: "blabla2"
    user.username.should == username
    user.reload.username.should == username
  end

  it "should detect lecturer" do
    user = build(:user)
    user.lecturer?.should be(false)
    user.mode = User::Lecturer
    user.lecturer?.should be(true)

    #user = build(:user)
    #user.lecturer?.should be(false)
    #user.current_step = 'screen_name'
    #user.lecturer?.should be(true)
    #user.mode = User::Lecturer
    #user.lecturer?.should be(true)
  end

  it "should become lecturer if screen_name is setted" do
    user = build(:user)
    user.lecturer?.should be(false)
    user.screen_name = "test#{Time.now.to_i}"
    user.save
    user.lecturer?.should be(true)
  end
 
  it "should valid screen_name as lecturer or in screen_step" do
    user = build(:user)
    user.screen_name_step?.should be(false)
    user.mode = User::Lecturer
    user.valid?.should be(false)
    user.errors[:screen_name].should_not be_nil
    user.mode = User::Undefined
    user.valid?.should be(true)
    user.current_step = :screen_name
    user.valid?.should be(false)
    user.errors[:screen_name].should_not be_nil
    user.screen_name_step?.should be(true)

  end

  it "should be valid for undefined user" do
    user = build(:user)
    user.new?.should   be(true)
    user.valid?.should be(true)

    user.mode = User::Lecturer
    user.valid?.should be(false)
  end


  { '' => false, "elvis.presley" => true, "test1234" => true, 'programowanie jest fajne' => false, 'śćółń' => false, 'ss' => false, '12345678912345678912345678' => false }.each do |sn, test|
    it "should return #{test.inspect} for #{sn.inspect} in screen_name" do
      user = build(:lecturer, screen_name: nil)
      user.new_record?.should be(true)
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

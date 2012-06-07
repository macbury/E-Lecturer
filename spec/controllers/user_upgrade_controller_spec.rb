require 'spec_helper'

describe UserUpgradeController do

  describe "for guest" do
    it "should be unauthorized" do
      get :show
      response.should be_redirect
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "for lecturer" do
    before { as_lecturer }
    it "should be unauthorized" do
      get :show
      response.should be_redirect
      response.should redirect_to(root_path)
    end

    it "should be authorized" do
      get :show, id: "finish"
      response.should be_redirect
      response.should redirect_to(root_path)
    end
  end

  describe "for normal user" do
    before { as_normal_user }
    it "should show first step" do
      get :show
      response.should be_redirect
    end
  end

end

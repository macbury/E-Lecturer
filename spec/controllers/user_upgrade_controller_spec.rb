require 'spec_helper'

describe UserUpgradeController do

  describe "as guest" do
    before { as_guest! }
    it "should be unauthorized" do
      get :index
      response.should be_redirect
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "as lecturer" do
    before { as_lecturer! }
    it "should be unauthorized" do
      get :index
      response.should be_redirect
      response.should redirect_to(user_upgrade_path(id: "confirm"))
    end

    it "should be unauthorized" do
      get :show, id: "confirm"
      response.should be_redirect
      response.should redirect_to(root_path)
    end

    it "should be authorized" do
      get :show, id: "finish"
      response.should be_redirect
      response.should redirect_to(root_path)
    end
  end

  describe "as student" do
    before { as_student! }
    it "should show first step" do
      get :index
      response.should redirect_to(user_upgrade_path(id: "confirm"))
    end
  end

end

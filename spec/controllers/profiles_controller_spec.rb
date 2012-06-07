require 'spec_helper'

describe ProfilesController do
  describe "for normal user" do
    before { as_normal_user }

    it "should show settings page" do
      get :edit
      response.should be_success
    end

  end

  describe "for lecturer user" do
    before { as_lecturer }

    it "should show settings page" do
      get :edit
      response.should be_success
    end
  end
end

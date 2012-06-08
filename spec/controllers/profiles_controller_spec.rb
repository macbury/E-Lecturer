require 'spec_helper'

describe ProfilesController do

  describe "for guest" do
    before { as_guest! }
    it "should show profile page" do
      lecturer = create(:lecturer)
      get :show, screen_name: lecturer.screen_name
      response.should be_success
    end
=begin
    it "should show 404 page" do
      get :show, screen_name: nil
      response.should be(404)
      response.should render_template("/shared/404")
    end
=end
  end

  describe "for normal user" do
    before { as_normal_user }

    it "should show settings page" do
      get :edit
      response.should be_success
    end

    it "should update config" do
      put :update, { user: {} }
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

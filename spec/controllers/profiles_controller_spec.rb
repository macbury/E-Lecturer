require 'spec_helper'

describe ProfilesController do

  describe "as guest" do
    before { as_guest! }
    it "should show profile page" do
      lecturer = create(:lecturer)
      get :show, screen_name: lecturer.screen_name
      response.should be_success
    end

    [:basic_info, :edit].each do |get_action|
      it "should redirect to login for #{get_action}" do
        get get_action
        response.should redirect_to(new_user_session_path)
      end
    end

    [:update_basic_info, :update].each do |action|
      it "should redirect to login for #{action}" do
        put action
        response.should redirect_to(new_user_session_path)
      end
    end 
=begin
    it "should show 404 page" do
      get :show, screen_name: nil
      response.should be(404)
      response.should render_template("/shared/404")
    end
=end
  end

  describe "as student" do
    before { as_normal_user }

    it "should show settings page" do
      get :edit
      response.should be_success
    end

    it "should update config" do
      put :update, { user: {} }
      response.should be_success
    end

    it "should show form for :basic_info" do
      get :basic_info
      response.should be_success
      response.should render_template(:basic_info)
    end

    it "should update basic info for valid data" do
      put :update_basic_info, user: {}
      response.should be_success
      response.should render_template(:basic_info)
    end

  end

  describe "as lecturer" do
    before { as_lecturer }

    it "should show settings page" do
      get :edit
      response.should be_success
    end

    it "should show form for :basic_info" do
      get :basic_info
      response.should be_success
      response.should render_template(:basic_info)
    end

    it "should update basic info for valid data" do
      put :update_basic_info, user: {}
      response.should be_success
      response.should render_template(:basic_info)
    end
  end
end

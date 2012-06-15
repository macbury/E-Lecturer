require 'spec_helper'

describe ProfilesController do

  describe "as guest" do
    before { as_guest! }
    
    it "should redirect to information path" do
      lecturer = create(:lecturer)
      get :dashboard, screen_name: lecturer.screen_name
      response.should redirect_to(information_path(screen_name: lecturer.username))
    end

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

    it "should redirect to information page if is not observing lecturer" do
      lecturer = create(:lecturer)
      get :dashboard, screen_name: lecturer.screen_name
      response.should redirect_to(information_path(screen_name: lecturer.username))
    end

    it "should redirect to timeline path if i visit my profile" do
      lecturer = build_observed_lecturer
      get :dashboard, screen_name: lecturer.screen_name
      response.should redirect_to(timeline_path(screen_name: lecturer.username))
    end

    it "should show profile page" do
      lecturer = create(:lecturer)
      get :show, screen_name: lecturer.screen_name
      response.should be_success
    end

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
    before { @lecturer = as_lecturer }

    it "should redirect to information page if i visit other lecturer profile" do
      lecturer = create(:lecturer)
      get :dashboard, screen_name: lecturer.screen_name
      response.should redirect_to(information_path(screen_name: lecturer.username))
    end

    it "should redirect to timeline path if i visit my profile" do
      get :dashboard, screen_name: @lecturer.screen_name
      response.should redirect_to(timeline_path(screen_name: @lecturer.username))
    end

    it "should show profile page for other lecturer" do
      lecturer = create(:lecturer)
      get :show, screen_name: lecturer.screen_name
      response.should be_success
      assigns(:lecturer).should_not eq(@lecturer)
    end

    it "should show profile for my profile page" do
      get :show, screen_name: @lecturer.screen_name
      response.should be_success
      assigns(:lecturer).should eq(@lecturer)
    end

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

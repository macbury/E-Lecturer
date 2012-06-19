require 'spec_helper'

describe FriendshipsController do

  describe "as guest" do
    before { as_guest! }
    
    it "should redirect to root path for new friendship" do
      lecturer = create(:lecturer)
      get :new, screen_name: lecturer.username

      response.should be_redirect
      response.should redirect_to(new_user_session_path)
    end

    it "should redirect to root path for create friendship" do
      lecturer = create(:lecturer)
      post :create, screen_name: lecturer.username

      response.should be_redirect
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "as student" do
    before { as_student! }

    it "should show new page if not observing lecturer" do
      lecturer = create(:lecturer)
      get :new, screen_name: lecturer.username

      response.should be_success
      response.should render_template("new")
    end

    it "should create friendship if not observing lecturer for valid data" do
      lecturer      = create(:lecturer)
      access_token  = lecturer.access_tokens.create(FactoryGirl.attributes_for(:access_token_for_form))

      post :create, screen_name: lecturer.username, friendship: { access_token: access_token.code }

      response.should_not render_template("new")
      response.should redirect_to(profile_page_path(screen_name: lecturer.username))
    end

    it "should not create friendship if not observing lecturer for invalid data" do
      lecturer      = create(:lecturer)
      post :create, screen_name: lecturer.username, friendship: { access_token: "test" }

      response.should render_template("new")
    end

    it "should redirect to profile page if observing lecturer" do
      lecturer = create(:lecturer)
      observe_lecturer!(lecturer)

      get :new, screen_name: lecturer.username

      response.should redirect_to(profile_page_path(screen_name: lecturer.username))
    end
  end

  describe "as lecturer" do
    before { as_lecturer! }

    it "should redirect to root path for other lecturer on new friendship" do
      lecturer = create(:lecturer)
      get :new, screen_name: lecturer.username
      response.should redirect_to(root_path)
    end

    it "should redirect to root path for other lecturer on create friendship" do
      lecturer = create(:lecturer)
      post :create, screen_name: lecturer.username
      response.should redirect_to(root_path)
    end

    it "should redirect to root path for the same lecturer on new friendship" do
      get :new, screen_name: controller.current_user.username
      response.should redirect_to(profile_page_path(screen_name: controller.current_user.username))
    end 

    it "should redirect to root path for the same lecturer on new friendship" do
      post :create, screen_name: controller.current_user.username
      response.should redirect_to(profile_page_path(screen_name: controller.current_user.username))
    end 
  end
end

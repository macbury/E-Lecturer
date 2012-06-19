require 'spec_helper'

describe TimelinesController do
  context "as guest" do
    before { as_guest! }
    
    it "should redirect to root path for index page" do
      lecturer = create(:lecturer)
      get :index, screen_name: lecturer.username

      response.should be_redirect
      response.should redirect_to(new_user_session_path)
    end
  end

  context "as not observing student" do
    before { as_student! }
    
    it "should redirect to root path for index page" do
      lecturer = create(:lecturer)
      get :index, screen_name: lecturer.username

      response.should be_redirect
      response.should redirect_to(profile_page_path(screen_name: lecturer.username))
    end
  end

  context "as observing student" do
    before { as_student! }
    
    it "should not redirect to root path for index page" do
      lecturer = create(:lecturer)
      observe_lecturer!(lecturer)
      get :index, screen_name: lecturer.username

      response.should be_success
      response.should render_template("index")
      response.should_not redirect_to(profile_page_path(screen_name: lecturer.username))
    end
  end

  context "as other lecturer" do
    before { as_lecturer! }
    
    it "should redirect to root path for index page" do
      lecturer = create(:lecturer)
      get :index, screen_name: lecturer.username

      response.should be_redirect
      response.should redirect_to(profile_page_path(screen_name: lecturer.username))
    end
  end

  context "as lecturer" do
    before { as_lecturer! }
    
    it "should redirect to root path for index page" do
      get :index, screen_name: controller.current_user.username

      response.should be_success
      response.should render_template("index")
      response.should_not redirect_to(profile_page_path(screen_name: controller.current_user.username))
    end
  end
end

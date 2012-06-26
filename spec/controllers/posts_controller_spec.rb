require 'spec_helper'

describe PostsController do

  context "as guest" do
    before { as_guest! }
    
    it "should redirect to root path for create post" do
      lecturer = create(:lecturer)
      post :create, screen_name: lecturer.username, post: {}

      response.should be_redirect
      response.should redirect_to(new_user_session_path)
    end
  end

  context "as not observing student" do
    before { as_student! }
    
    it "should redirect to root path for index page" do
      lecturer = create(:lecturer)
      post :create, screen_name: lecturer.username, post: {}

      response.should be_redirect
      response.should redirect_to(profile_page_path(screen_name: lecturer.screen_name))
    end
  end

  context "as observing student" do
    before { as_student! }
    
    it "should be success for valid post data" do
      lecturer = build_observed_lecturer

      post :create, screen_name: lecturer.username, post: FactoryGirl.attributes_for(:post)

      response.should be_success
    end

    it "should not be success for valid post data" do
      lecturer = build_observed_lecturer

      post :create, screen_name: lecturer.username, post: {}

      response.should_not be_success
    end
  end

  context "as other lecturer" do
    before { as_lecturer! }
    
    it "should redirect to root path for index page" do
      lecturer = create(:lecturer)
      post :create, screen_name: lecturer.username, post: {}

      response.should be_redirect
      response.should redirect_to(profile_page_path(screen_name: lecturer.screen_name))
    end
  end

  context "as lecturer" do
    before { as_lecturer! }
    
    it "should be success for valid post data" do
      post :create, screen_name: controller.current_user.username, post: FactoryGirl.attributes_for(:post)

      response.should be_success
    end

    it "should not be success for valid post data" do
      post :create, screen_name: controller.current_user.username, post: {}

      response.should_not be_success
    end
  end

end

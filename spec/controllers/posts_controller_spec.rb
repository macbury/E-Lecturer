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

  context "as not observing lecturer" do
    before { as_lecturer! }
    
    it "should redirect to root path for index page" do
      lecturer = create(:lecturer)
      post :create, screen_name: lecturer.username, post: {}

      response.should be_redirect
      response.should redirect_to(profile_page_path(screen_name: lecturer.screen_name))
    end
  end

end

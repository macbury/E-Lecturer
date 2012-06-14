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
  end

  describe "as student" do
    before { as_student! }

    it "should show new page if not observing lecturer" do
      lecturer = create(:lecturer)
      get :new, screen_name: lecturer.username

      response.should be_success
      response.should render_template("new")
      assigns(:friendship).friend.should  eq(controller.current_user)
      assigns(:friendship).user.should    eq(lecturer)
    end

    it "should redirect to profile page if observing lecturer" do
      lecturer = create(:lecturer)
      observe!(lecturer)
      get :new, screen_name: lecturer.username

      response.should redirect_to(profile_path(screen_name: lecturer.username))
    end
  end

  describe "as lecturer" do
    before { as_lecturer! }

    it "should redirect to root path for other lecturer" do
      lecturer = create(:lecturer)
      get :new, screen_name: lecturer.username
      response.should redirect_to(root_path)
    end

    it "should redirect to root path for the same lecturer" do
      get :new, screen_name: controller.current_user.username
      response.should redirect_to(root_path)
    end 
  end
end

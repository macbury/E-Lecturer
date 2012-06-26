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

    it "should redirect to root path for show page" do
      lecturer = create(:lecturer)
      get :show, screen_name: lecturer.username, id: -1

      response.should be_redirect
      response.should redirect_to(new_user_session_path)
    end

    it "should redirect to root path destroy action" do
      lecturer = create(:lecturer)
      delete :destroy, screen_name: lecturer.username, id: -1

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

    it "should redirect to root path for show page" do
      lecturer = create(:lecturer)
      get :show, screen_name: lecturer.username, id: -1

      response.should be_redirect
      response.should redirect_to(profile_page_path(screen_name: lecturer.username))
    end

    it "should redirect to root path for delete actiona" do
      lecturer = create(:lecturer)
      delete :destroy, screen_name: lecturer.username, id: -1, format: :json

      response.should be_redirect
      response.should redirect_to(profile_page_path(screen_name: lecturer.username))
    end
  end

  context "as observing student" do
    before { as_student! }
    
    it "should show index action" do
      lecturer = build_observed_lecturer
      post_on_lecturer_wall!(lecturer)

      get :index, screen_name: lecturer.username

      response.should be_success
      response.should render_template("index")
      response.should_not redirect_to(profile_page_path(screen_name: lecturer.username))
    end

    it "should show post by lecturer" do
      lecturer = build_observed_lecturer
      @post = post_on_lecturer_wall!(lecturer)

      get :show, screen_name: lecturer.username, id: @post.stream.id

      assigns(:stream).should eq(@post.stream)
      response.should be_success
      response.should render_template("show")
    end

    it "should delete stream" do
      lecturer = build_observed_lecturer
      @post = post_on_lecturer_wall!(lecturer)

      delete :destroy, screen_name: lecturer.username, id: @post.stream.id, format: :json

      response.should be_success
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

    it "should redirect to root path for show page" do
      lecturer = create(:lecturer)
      get :show, screen_name: lecturer.username, id: -1

      response.should be_redirect
      response.should redirect_to(profile_page_path(screen_name: lecturer.username))
    end

    it "should redirect to root path for delete actiona" do
      lecturer = create(:lecturer)
      delete :destroy, screen_name: lecturer.username, id: -1, format: :json

      response.should be_redirect
      response.should redirect_to(profile_page_path(screen_name: lecturer.username))
    end

  end

  context "as lecturer" do
    before { as_lecturer! }
    
    it "should redirect to root path for index page" do
      lecturer = controller.current_user
      post_on_lecturer_wall!(lecturer)

      get :index, screen_name: controller.current_user.username

      response.should be_success
      response.should render_template("index")
      response.should_not redirect_to(profile_page_path(screen_name: controller.current_user.username))
    end

    it "should show post by lecturer" do
      lecturer = controller.current_user
      @post = post_on_lecturer_wall!(lecturer)

      get :show, screen_name: lecturer.username, id: @post.stream.id

      assigns(:stream).should eq(@post.stream)
      response.should be_success
      response.should render_template("show")
    end

    it "should delete stream" do
      lecturer = controller.current_user
      @post = post_on_lecturer_wall!(lecturer)

      delete :destroy, screen_name: lecturer.username, id: @post.stream.id, format: :json

      response.should be_success
    end
  end
end

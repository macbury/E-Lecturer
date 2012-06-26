require 'spec_helper'

describe DashboardController do
  
  context "as guest" do
    before { as_guest! }
    it "should redirect to login path for index action" do
      get :index
      response.should be_redirect
      response.should redirect_to(new_user_session_path)
    end
  end

  context "as student" do
    before { as_student! }
    it "should render index action" do
      get :index
      response.should render_template("index")
      response.should be_success
    end
  end

  context "as lecturer" do
    before { as_lecturer! }
    it "should redirect root path" do
      get :index
      response.should be_redirect
      response.should redirect_to(root_path)
    end
  end

end

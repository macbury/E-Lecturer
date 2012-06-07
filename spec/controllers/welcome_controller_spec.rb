require 'spec_helper'

describe WelcomeController do

  it "should render action index for guest" do
    get :index
    response.should render_template("index")
    response.should be_success
  end

  it "should redirect to dashboard if normal user" do
    sign_in_as_user
    get :index

    response.should_not render_template("index")
    response.should be_redirect
    response.should redirect_to(dashboard_path)
  end

  it "should redirect to profile if lecturer" do
    user = as_lecturer

    get :index

    response.should_not render_template("index")
    response.should be_redirect
    response.should redirect_to(profile_path(screen_name: user.screen_name))
  end

end

require 'spec_helper'


describe AccessTokensController do

  describe "as guest" do
    before { as_guest! }

    [:index, :new].each do |action|
      it "should for GET #{action} redirect to login page" do
        get action
        response.should be_redirect
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  describe "as student" do
    before { as_student! }

    [:index, :new].each do |action|
      it "should for GET #{action} redirect to root path" do
        get action
        response.should be_redirect
        response.should redirect_to(root_path)
      end
    end
  end


  describe "as lecturer" do
    before { as_lecturer! }

    it "should show list of access tokens" do
      3.times { controller.current_user.access_tokens.create(FactoryGirl.attributes_for(:access_token_for_form)) }
      controller.current_user.save

      get :index
      response.should be_success
      response.should render_template("index")
      assigns(:access_tokens).should eq(controller.current_user.access_tokens)
    end
  end

end

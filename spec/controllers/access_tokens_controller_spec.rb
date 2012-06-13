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

    [:create].each do |action|
      it "should for POST #{action} redirect to login page" do
        post action
        response.should be_redirect
        response.should redirect_to(new_user_session_path)
      end
    end 

    it "should for DELETE destrou redirect to login page" do
      delete :destroy
      response.should be_redirect
      response.should redirect_to(new_user_session_path)
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

    [:create].each do |action|
      it "should for POST #{action} redirect to root path" do
        post action
        response.should be_redirect
        response.should redirect_to(root_path)
      end
    end
    
    it "should for DELETE destrou redirect to root path" do
      controller.current_user.access_tokens.create(FactoryGirl.attributes_for(:access_token_for_form))
      delete :destroy, id: controller.current_user.access_tokens.first.id
      response.should be_redirect
      response.should redirect_to(root_path)
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

    it "should show new access token page with form" do
      get :new
      response.should be_success
      response.should render_template("new")
    end

    it "should show form for invalid access_token attributes" do
      post :create, {}
      response.should render_template("new")
    end

    it "should redirect to access_token root path if token is valid!" do
      post :create, { access_token: FactoryGirl.attributes_for(:access_token_for_form) }
      response.should be_redirect
      response.should redirect_to(access_tokens_path)
    end

    it "should for DELETE destroy redirect to access_tokens page" do
      controller.current_user.access_tokens.create(FactoryGirl.attributes_for(:access_token_for_form))
      delete :destroy, id: controller.current_user.access_tokens.first.id

      response.should be_redirect
      response.should redirect_to(access_tokens_path)
    end
  end

end

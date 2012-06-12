require 'spec_helper'


describe AccessTokensController do

  describe "as guest" do
    before { as_guest! }

    [:index].each do |action|
      it "should for GET #{action} redirect to login page" do
        get action
        response.should be_redirect
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  describe "as student" do
    before { as_student! }

    [:index].each do |action|
      it "should for GET #{action} redirect to root path" do
        get action
        response.should be_redirect
        response.should redirect_to(root_path)
      end
    end
  end

end

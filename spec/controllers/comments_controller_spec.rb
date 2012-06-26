require 'spec_helper'

describe CommentsController do

  [:post].each do |klass|

    context "for #{klass}" do

      context "as guest" do
        before { as_guest! }
        
        it "should redirect to login path for create comment" do
          lecturer = create(:lecturer)
          post :create, screen_name: lecturer.username, comment: {}, "#{klass}_id".to_sym => -1

          response.should be_redirect
          response.should redirect_to(new_user_session_path)
        end
      end

      context "as not observing student" do
        before { as_student! }
        
        it "should redirect to root path for index page" do
          lecturer = create(:lecturer)
          post :create, screen_name: lecturer.username, comment: {}, "#{klass}_id".to_sym => -1

          response.should be_redirect
          response.should redirect_to(profile_page_path(screen_name: lecturer.screen_name))
        end
      end

      context "as observing student" do
        before { as_student! }

        it "should be success for valid post data" do
          lecturer = build_observed_lecturer
          klass_object = create_stream_object!(klass, lecturer)

          post :create, screen_name: lecturer.username, "#{klass}_id".to_sym => klass_object.id, comment: FactoryGirl.attributes_for(:comment)

          response.should be_success
        end

        it "should be unsuccess for invalid post data" do
          lecturer = build_observed_lecturer
          klass_object = create_stream_object!(klass, lecturer)

          post :create, screen_name: lecturer.username, "#{klass}_id".to_sym => klass_object.id, comment: {}

          response.should_not be_success
        end
      end

      context "as other lecturer" do
        before { as_lecturer! }
        
        it "should redirect to root path for index page" do
          lecturer = create(:lecturer)
          klass_object = create_stream_object!(klass, lecturer)
          post :create, screen_name: lecturer.username, "#{klass}_id".to_sym => klass_object.id, comment: {}

          response.should be_redirect
          response.should redirect_to(profile_page_path(screen_name: lecturer.screen_name))
        end
      end

      context "as lecturer" do
        before { as_lecturer! }
        
        it "should be success for valid post data" do
          lecturer = controller.current_user
          klass_object = create_stream_object!(klass, lecturer)
          post :create, screen_name: lecturer.username, "#{klass}_id".to_sym => klass_object.id, comment: FactoryGirl.attributes_for(:comment)

          response.should be_success
        end

        it "should not be success for valid post data" do
          lecturer = controller.current_user
          klass_object = create_stream_object!(klass, lecturer)
          post :create, screen_name: lecturer.username, "#{klass}_id".to_sym => klass_object.id, comment: {}

          response.should_not be_success
        end
      end

    end
  end

end

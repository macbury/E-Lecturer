module UserHelper
  def observe_lecturer!(lecturer)
    access_token = lecturer.access_tokens.create(FactoryGirl.attributes_for(:access_token_for_form))
    controller.current_user.connect_with!(lecturer, access_token: access_token.code)
  end
end
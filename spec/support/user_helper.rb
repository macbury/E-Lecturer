module UserHelper
  def observe_lecturer!(lecturer)
    user_observe_lecturer!(controller.current_user, lecturer)
  end

  def user_observe_lecturer!(user, lecturer)
    access_token = lecturer.access_tokens.create(FactoryGirl.attributes_for(:access_token_for_form))
    user.connect_with!(lecturer, access_token: access_token.code)
  end
end
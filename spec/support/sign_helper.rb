module SignHelper
  def as_guest
    sign_out :user
  end
  def sign_in_as_user
    user = FactoryGirl.create(:user)
    user.confirm!
    sign_in user
    user
  end

  def as_normal_user
    user = FactoryGirl.create(:user)
    user.confirm!
    sign_in user
    user
  end

  def as_lecturer
    user = FactoryGirl.create(:lecturer)
    user.confirm!
    sign_in user
    user
  end

  def logout!
    sign_out :user
  end

  def as_guest!
    sign_out :user
  end

  def as_student!
    as_normal_user
  end

  def as_lecturer!
    as_lecturer
  end

  def observe!(user)
    access_token = user.access_tokens.create(FactoryGirl.attributes_for(:access_token_for_form))
    controller.current_user.connect_with!(user, access_token: access_token.code)
  end

  def build_observed_lecturer
    lecturer = create(:lecturer)
      
    access_token = lecturer.access_tokens.create(FactoryGirl.attributes_for(:access_token_for_form))
    controller.current_user.connect_with!(lecturer, access_token: access_token.code)
    lecturer
  end
end
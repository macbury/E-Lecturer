module SignHelper
  def sign_in_as_user
    user = FactoryGirl.create(:user)
    user.confirm!
    sign_in user
    user
  end

  def logout!
    sign_out
  end
end
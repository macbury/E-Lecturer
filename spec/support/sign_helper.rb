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
end
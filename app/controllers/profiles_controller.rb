# encoding: UTF-8
class ProfilesController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def update
    authorize! :edit, self.current_user
    @user = current_user
    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to root_path, :notice => I18n.t("flash.info.change_password", default: "Hasło zostało zmienione!")
    else
      render :edit
    end
  end

  def show
    @user = User.is_lecturer.find_by_screen_name!(params[:screen_name])
  end

end

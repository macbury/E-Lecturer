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
    @current_tab    = :information
    @user           = User.is_lecturer.find_by_username!(params[:screen_name])
    @user_decorator = UserDecorator.new(@user)
  end

  def basic_info
    authorize! :basic_info, self.current_user
  end

  def update_basic_info
    authorize! :basic_info, self.current_user
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] =  I18n.t("flash.info.save_basic_info", default: "Zapisano zmiany")
    else
      flash[:error] =  I18n.t("flash.error.save_basic_info", default: "Nie można zapisać zmian")
    end
    render :basic_info
  end
end

# encoding: UTF-8
class ProfilesController < ApplicationController
  before_filter :authenticate_user!,  except: [:show, :dashboard]
  before_filter :preload_lecturer!,   only: [:show, :dashboard]

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

  def dashboard
    if user_signed_in? && (current_user.friend_with?(@lecturer) || current_user == @lecturer)
      redirect_to timeline_path(screen_name: @lecturer.username)
    else
      redirect_to information_path(screen_name: @lecturer.username)
    end
  end

  def show
    @current_tab        = :information
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

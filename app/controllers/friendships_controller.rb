# encoding: UTF-8
class FriendshipsController < ApplicationController
  before_filter :authenticate_user!, :preload_lecturer!, :is_not_observing!

  def new
    @friendship = self.current_user.friendships.new
    authorize! :new, @friendship
  end

  def create
    @friendship = self.current_user.connect_with!(@lecturer, params[:friendship])
    authorize! :create, @friendship

    if @friendship.valid?
      redirect_to profile_page_path(screen_name: @lecturer.username), notice: I18n.t("flash.info.save_access_token", default: "Masz dostęp do zasobów wykładowcy")
    else
      flash[:error] = I18n.t("flash.error.save_friendship", default: "Błąd")
      render action: "new"
    end
  end


end

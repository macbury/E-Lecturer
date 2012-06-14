# encoding: UTF-8
class FriendshipsController < ApplicationController
  before_filter :authenticate_user!, :preload_lecturer!, :is_not_observing!

  def new
    @friendship = build_friendship
    authorize! :new, @friendship
  end

  def create
    @friendship = build_friendship(params[:friendship])
    authorize! :create, @friendship

    if @friendship.save
      redirect_to profile_path(screen_name: @lecturer.username), notice: I18n.t("flash.info.save_access_token", default: "Masz dostęp do zasobów wykładowcy")
    else
      flash[:error] = I18n.t("flash.error.save_friendship", default: "Błąd")
      render action: "new"
    end
  end

  protected

    def build_friendship(attrs={})
      friendship = Friendship.new(attrs)
      friendship.student_id = self.current_user.id
      friendship.lecturer_id = @lecturer.id
      friendship
    end


end

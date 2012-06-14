# encoding: UTF-8
class FriendshipsController < ApplicationController
  before_filter :authenticate_user!, :preload_lecturer!

  def new
    @friendship = build_friendship
    authorize! :new, @friendship
  end

  def create
    @friendship = build_friendship(params[:friendship])
    authorize! :create, @friendship

    if @friendship.save
      redirect_to access_tokens_path, notice: I18n.t("flash.info.save_access_token", default: "Dodano nowy kod dostępu!")
    else
      flash[:error] = I18n.t("flash.error.save_friendship", default: "Nie możnda")
      render action: "new"
    end
  end

  protected

    def build_friendship(attrs={})
      friendship = @lecturer.friendships.new(attrs)
      friendship.friend_id = self.current_user.id
      friendship
    end
end

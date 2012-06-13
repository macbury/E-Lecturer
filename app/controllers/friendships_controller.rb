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
  end

  protected

    def build_friendship(attrs={})
      friendship = self.current_user.friendships.new(attrs)
      friendship.friend_id = self.current_user.id
      friendship
    end
end

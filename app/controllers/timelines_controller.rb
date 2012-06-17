# encoding: UTF-8
class TimelinesController < ApplicationController
  before_filter :authenticate_user!, :preload_lecturer!, :is_observing!

  def show
    @current_tab = :timeline
    authorize! :timeline, @lecturer

    @streams       = @lecturer.streams.order("streams.created_at DESC").includes(:streamable)
  end

end

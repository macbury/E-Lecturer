# encoding: UTF-8
class TimelinesController < ApplicationController
  before_filter :authenticate_user!, :preload_lecturer!, :is_observing!

  def show
    @current_tab = :timeline
    authorize! :timeline, @lecturer

    @streams        = @lecturer.streams.order("streams.created_at DESC").includes({ :streamable => :user }, :lecturer)

    respond_to do |format|
      format.html
      format.json { render partial: "timelines/stream", collection: @streams }
    end
  end

end

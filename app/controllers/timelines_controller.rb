# encoding: UTF-8
class TimelinesController < ApplicationController
  before_filter :authenticate_user!, :preload_lecturer!, :is_observing!

  def show
    @current_tab = :timeline
    authorize! :timeline, @lecturer

    @streams              = @lecturer.streams.page(params[:page]).per(10).order("streams.created_at DESC").includes({ :streamable => :user }, :lecturer)
    respond_to do |format|
      format.html { gon.jbuilder as: :streams }
      format.json { render action: "index" }
    end
  end

end

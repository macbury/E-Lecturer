# encoding: UTF-8
class TimelinesController < ApplicationController
  StreamsPerPage = 10
  before_filter :authenticate_user!, :preload_lecturer!, :is_observing!

  def show
    @current_tab = :timeline
    authorize! :timeline, @lecturer
    @page = (params[:page] || 0).to_i

    @streams  = @lecturer.streams.page(params[:page]).per(StreamsPerPage).order("streams.created_at DESC").includes({ :streamable => :user }, :lecturer)

    respond_to do |format|
      format.html do 
        gon.jbuilder as: :streams
        gon.pagination page: @page, per_page: TimelinesController::StreamsPerPage, total_count: @streams.total_count, page_count: @streams.total_count / TimelinesController::StreamsPerPage
      end
      format.json { render action: "index" }
    end
  end

end

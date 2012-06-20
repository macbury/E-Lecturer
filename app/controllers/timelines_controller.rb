# encoding: UTF-8
class TimelinesController < ApplicationController
  StreamsPerPage = 10
  before_filter :authenticate_user!, :preload_lecturer!, :is_observing!

  def show
    @current_tab = :timeline
    authorize! :timeline, @lecturer
    @page = (params[:page] || 1).to_i

    @streams  = @lecturer.streams.page(params[:page]).per(StreamsPerPage).order("streams.created_at DESC").includes({ :streamable => :user }, :lecturer)

    respond_to do |format|
      format.html do
        gon.pagination = { page: @page, per_page: TimelinesController::StreamsPerPage, total_count: @streams.total_count, page_count: @streams.total_count / TimelinesController::StreamsPerPage }
        gon.jbuilder as: :streams
      end
      format.json
    end
  end

  def destroy
    @stream  = @lecturer.streams.find(params[:id])
    authorize! :destroy, @stream

    respond_to do |format|
      if @stream.destroy
        format.json { render json: true }
      else
        format.json { render json: false }
      end
    end
  end
end

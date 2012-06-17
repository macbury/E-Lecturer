# encoding: UTF-8
class TimelinesController < ApplicationController
  before_filter :authenticate_user!, :preload_lecturer!, :is_observing!

  def show
    @current_tab = :timeline
    authorize! :timeline, @lecturer

    @streams        = @lecturer.streams.order("streams.created_at DESC").includes({ :streamable => :user }, :lecturer).all
    @last_stream_id = @streams.first.id if @streams.size > 0

    respond_to do |format|
      format.html
      format.json do
        output = {}
        @streams.each do |stream|
          output[stream.id] = render_to_string(partial: stream.streamable, locals: { stream: stream }, formats: [:html])
        end
        render json: { prepend: output } 
      end
    end
  end

end

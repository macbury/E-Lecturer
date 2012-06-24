
class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :dashboard, self.current_user
    @lecturers = self.current_user.friends
    @page = (params[:page] || 1).to_i

    @streams  = Stream.where(lecturer_id: @lecturers.map(&:id)).is_post.page(params[:page]).per(TimelinesController::StreamsPerPage).order("streams.created_at DESC").includes({ :streamable => [:user, { :comments => :user }] }, :lecturer)

    respond_to do |format|
      format.html do
        gon.pagination = { page: @page, per_page: TimelinesController::StreamsPerPage, total_count: @streams.total_count, page_count: @streams.total_count / TimelinesController::StreamsPerPage }
        gon.jbuilder as: :streams
      end
      format.json
    end
  end

end

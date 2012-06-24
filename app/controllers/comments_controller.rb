class CommentsController < ApplicationController
  before_filter :authenticate_user!, :preload_lecturer!, :is_observing!
  helper_method :find_commentable

  def create
    @comment       = find_commentable.comments.new(params[:comment])
    @comment.user  = self.current_user

    authorize! :create, @comment

    if @comment.save
      render status: :ok, formats: [:json]
    else
      render partial: "form", locals: { comment: @comment, commetable: find_commentable, lecturer: current_lecturer }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment       = find_commentable.comments.find(params[:id])
    authorize! :destroy, @comment
    
    if @comment.destroy
      render json: true
    else
      render json: false
    end
  end

  protected

    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          @commentable ||= $1.classify.constantize.find(value)
          return @commentable
        end
      end
      nil
    end
end

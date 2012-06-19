# encoding: UTF-8
class PostsController < ApplicationController
  before_filter :authenticate_user!, :preload_lecturer!, :is_observing!

  def create
    @post       = Post.new(params[:post])
    @post.user  = self.current_user

    authorize! :create, @post

    if @post.save
      @lecturer.posts << @post
      form_html = render_to_string(partial: "form", locals: { post: Post.new })
      post_html = render_to_string(partial: @post, locals: { stream: @post.stream }, formats: [:html])
      render json: { form: form_html, stream: { html: post_html, created_at: @post.stream.created_at, id: stream.id } }, status: :ok
    else
      render partial: "form", locals: { post: @post }, status: :unprocessable_entity
    end
  end

end

# encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :lecturer?, :current_user_decorator
  
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.info "Unauthorized access: #{exception.message.bold}".red
    redirect_to root_url, :alert => exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do
    Rails.logger.info "Page not found".yellow
    render template: "/shared/404", status: 404
  end

  protected
    def current_user_decorator
      @current_user_decorator || UserDecorator.new(self.current_user)
    end

    def lecturer?
      user_signed_in? && self.current_user.lecturer?
    end

    def preload_lecturer!
      @lecturer = User.is_lecturer.find_by_username!(params[:screen_name])
    end

end

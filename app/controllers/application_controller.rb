class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

    def lecturer?
      user_signed_in? && self.current_user.lecturer?
    end
end

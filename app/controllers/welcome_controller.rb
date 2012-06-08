
class WelcomeController < ApplicationController

  def index

    if user_signed_in?
      if lecturer?
        redirect_to profile_page_path(screen_name: self.current_user.screen_name)
      else
        redirect_to dashboard_path
      end
    end

  end

end

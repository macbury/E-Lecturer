class AccessTokensController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, AccessToken
    @access_tokens = self.current_user.access_tokens.all
  end

  def new
    @access_token = self.current_user.access_tokens.new
    authorize! :new, @access_token
  end
end

# encoding: UTF-8
class AccessTokensController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, AccessToken
    @access_tokens            = self.current_user.access_tokens.order("created_at DESC").all
    @access_tokens_decorators = AccessTokenDecorator.decorate(@access_tokens)
  end

  def new
    @access_token = self.current_user.access_tokens.new
    @access_token.expire_at = 1.month.from_now
    authorize! :new, @access_token
  end

  def create
    @access_token = self.current_user.access_tokens.new(params[:access_token])
    authorize! :create, @access_token
    
    if @access_token.save
      redirect_to access_tokens_path, notice: I18n.t("flash.info.save_access_token", default: "Dodano nowy kod dostępu!")
    else
      flash[:error] = I18n.t("flash.error.save_access_token", default: "Nie można dodać kodu dostępu")
      render action: "new"
    end
  end

  def destroy
    @access_token = self.current_user.access_tokens.find(params[:id])
    authorize! :destroy, @access_token

    @access_token.destroy
    flash[:notice] = I18n.t("flash.info.destroy_access_token", default: "Kod dostępu został dezaktywowany.")
    redirect_to access_tokens_path
  end
end

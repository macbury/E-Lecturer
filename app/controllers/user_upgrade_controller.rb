class UserUpgradeController < ApplicationController
  include Wicked::Wizard
  before_filter :authenticate_user!
  steps :confirm, :screen_name

  def show
    authorize! "upgrade_step_#{step.to_s}".to_sym, self.current_user

    render_wizard
  end

  def update
    @user = self.current_user
    authorize! :upgrade, @user

    @user.current_step = step
    @user.update_attributes(params[:user])
    render_wizard @user
  end
end

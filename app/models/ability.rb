class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :upgrade_step_finish, User
    if user.new?
      can [:upgrade, :upgrade_step_confirm, :upgrade_step_screen_name], User
    end

    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end

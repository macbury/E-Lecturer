class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new

    can :upgrade_step_finish, User

    can :observe, User do |u| 
      u.id != current_user.id 
    end

    if current_user.new?
      can [:upgrade, :upgrade_step_confirm, :upgrade_step_screen_name], User
    end

    can :basic_info, User

    can :edit, User do |user|
      current_user.id == user.id
    end

    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end

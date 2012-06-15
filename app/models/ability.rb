class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new

    can :upgrade_step_finish, User

    if current_user.lecturer?
      can :manage, AccessToken
    end

    if current_user.student?
      can :observe, User do |user|
        user != current_user && !current_user.friend_with?(user)
      end
      can [:new, :create], Friendship
      can [:upgrade, :upgrade_step_confirm, :upgrade_step_screen_name], User
    end

    can :basic_info, User

    can :edit, User do |user|
      current_user.id == user.id
    end

  end
end

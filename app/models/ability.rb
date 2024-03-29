class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new

    can :upgrade_step_finish, User
    can :create, Post

    unless current_user.new_record?
      can [:create, :destroy], Comment do |comment|
        comment.user_id == current_user.id || comment.commentable.stream.lecturer_id == current_user.id
      end
      can :show, Stream
      can [:destroy], Stream do |stream|
        stream.lecturer_id == current_user.id || stream.streamable.user_id == current_user.id
      end
    end
    if current_user.lecturer?
      can :manage, AccessToken
      can [:view_profile, :timeline], User do |lecturer|
        current_user == lecturer
      end
    end

    if current_user.student?
      can :dashboard, User do |user| 
        user == current_user
      end
      can :observe, User do |user|
        user != current_user && !current_user.friend_with?(user)
      end
      can [:new, :create], Friendship
      can [:index,:upgrade, :upgrade_step_confirm, :upgrade_step_screen_name], User

      can [:view_profile, :timeline], User do |lecturer|
        current_user.friend_with?(lecturer) 
      end

      can [:create, :new], Friendship
    end

    can :basic_info, User

    can :edit, User do |user|
      current_user.id == user.id
    end

  end
end

class User < ActiveRecord::Base
  Undefined               = 0
  Lecturer                = 1
  Normal                  = 2

  devise                  :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  attr_accessible         :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :screen_name, :phone, :twitter, :facebook, :reset_password_token
  attr_accessor           :current_step

  has_and_belongs_to_many :titles
  has_many                :friendships
  has_many                :friends, through: :friendships
  has_many                :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many                :inverse_friends, through: :inverse_friendships, source: :user

  #validates               :first_name, :last_name, :screen_name, presence: true, if: :lecturer?
  validates               :screen_name, presence: true, uniqueness: true, format: /^[a-z\.\-0-9]+$/, length: { in: 3..18 }, if: :screen_name_step?

  def screen_name=(new_screen_name)
    write_attribute :screen_name, new_screen_name
    self.mode = User::Lecturer
  end

  def lecturer?
    self.mode == User::Lecturer
  end

  def screen_name_step?
    self.current_step == :screen_name || self.lecturer?
  end

  def lecturer!
    self.mode = User::Lecturer
    self.save!
  end

  def new?
    self.mode == User::Undefined
  end

  def normal?
    self.mode == User::Normal
  end

  def full_name
    [self.first_name, self.last_name].join(" ")
  end
end

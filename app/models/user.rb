class User < ActiveRecord::Base
  Undefined               = 0
  Lecturer                = 1
  Normal                  = 2

  mount_uploader          :picture, UserPosterUploader
  devise                  :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  attr_accessible         :email, :password, :password_confirmation, :remember_me, :reset_password_token, :title_ids, :picture_cache, :username
  attr_accessible         :first_name, :last_name, :screen_name, :phone, :about, :picture, :university, :birth_date, :become_lecturer

  attr_accessor           :current_step, :become_lecturer

  has_and_belongs_to_many :titles
  has_many                :friendships
  has_many                :friends, through: :friendships
  has_many                :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many                :inverse_friends, through: :inverse_friendships, source: :user
  has_many                :access_tokens, dependent: :destroy

  validates               :username, presence: true, uniqueness: true, format: /^[a-z\.\-0-9]+$/, length: { in: 3..24 }
  validates               :first_name, :last_name, presence: true, if: :screen_name_step?
  scope                   :is_lecturer, where(mode: User::Lecturer)

  def screen_name
    self.username
  end

  def become_lecturer=(new_mode)
    write_attribute :mode, User::Lecturer if screen_name_step?
  end

  def username=(new_user_name)
    write_attribute :username, new_user_name if self.new_record?
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

  def following?(user)
    self.friendships.where(friend_id: user.id).pluck(:id).present?
  end
end

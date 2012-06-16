class User < ActiveRecord::Base
  include Amistad::FriendModel
  
  Undefined               = 0
  Lecturer                = 1
  Normal                  = 2

  mount_uploader          :picture, UserPosterUploader
  devise                  :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  attr_accessible         :email, :password, :password_confirmation, :remember_me, :reset_password_token, :title_ids, :picture_cache, :username
  attr_accessible         :first_name, :last_name, :screen_name, :phone, :about, :picture, :university, :birth_date, :become_lecturer

  attr_accessor           :current_step, :become_lecturer

  has_and_belongs_to_many :titles
  has_many                :access_tokens, dependent: :destroy
  has_many                :lecturer_streams, dependent: :destroy, class_name: "Stream", foreign_key: "lecturer_id"
  has_many                :lecturer_posts, through: :lecturer_streams, source: :streamable, source_type: "Post"

  has_many                :streams, dependent: :destroy
  has_many                :posts, through: :streams, source: :streamable, source_type: "Post"

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

  def student?
    new?
  end

  def full_name
    [self.first_name, self.last_name].join(" ")
  end

  def connect_with!(user,attrs={})
    return false if user == self || find_any_friendship_with(user)
    friendship                = Friendship.new(attrs)
    friendship.user_id        = self.id
    friendship.friend_id      = user.id
    if friendship.save
      user.approve(self)
      friendship
    else
      friendship
    end
  end

end

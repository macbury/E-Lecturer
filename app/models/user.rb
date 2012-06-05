class User < ActiveRecord::Base
  Undefined               = 0
  Lecturer                = 1
  Normal                  = 2

  devise                  :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  attr_accessible         :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :screen_name, :phone, :twitter, :facebook
  
  has_and_belongs_to_many :titles

  validates               :first_name, :last_name, :screen_name, presence: true, if: :lecturer?
  validates               :screen_name, uniqueness: true, format: /^[a-z\.\-0-9]+$/, if: :lecturer?

  def lecturer?
    self.mode == User::Lecturer
  end

  def new?
    self.mode == User::Undefined
  end

  def normal?
    self.mode == User::Normal
  end
end

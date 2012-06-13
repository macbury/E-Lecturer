class AccessToken < ActiveRecord::Base
  belongs_to        :user
  attr_accessible   :expire_at, :name

  validates         :user_id, :expire_at, :code, presence: true

  before_validation :assign_code

  scope             :expired, -> { where("expire_at < ?", Time.now) }

  def assign_code
    self.code = AccessToken.generate_code!
  end

  def expired?
    self.expire_at < Time.now
  end

  def self.generate_code!
    while true
      code = (1000000+(rand*900000)).round.to_s(32)
      break if AccessToken.where(code: code).first.nil?
    end

    code
  end
end

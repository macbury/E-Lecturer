class AccessToken < ActiveRecord::Base
  belongs_to        :user
  attr_accessible   :expire_at, :name

  validates         :user_id, :expire_at, :code, presence: true
  validates         :name, allow_blank: true, length: { maximum: 34 }

  before_validation :assign_code

  scope             :expired, -> { where("expire_at < ?", Time.now) }

  def assign_code
    self.code = AccessToken.generate_code!
    Rails.logger.debug "Generated: #{self.code.bold}".yellow
  end

  def expired?
    self.expire_at < Time.now
  end

  def self.generate_code!
    while true
      code = SecureRandom.hex(3)
      break if AccessToken.where(code: code).first.nil?
    end

    code
  end
end

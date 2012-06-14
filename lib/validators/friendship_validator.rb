# encoding: UTF-8
class FriendshipValidator < ActiveModel::Validator
  
  def validate(record)
    record.errors[:user_id] << I18n.t("errors.friendship.lecturer", default: "musi być wykładowcą") if record.user.nil? || !record.user.lecturer?
    record.errors[:friend_id] << I18n.t("errors.friendship.student", default: "musi być studentem") if record.friend.nil? || !record.friend.student?
    
    if !record.user.nil?
      at = record.user.access_tokens.where(code: record.access_token).first

      if at.nil?
        record.errors[:access_token] << I18n.t("errors.friendship.no_access_token", default: "jest nieprawidłowy")
      elsif at.expired?
        record.errors[:access_token] << I18n.t("errors.friendship.expired", default: "wygasł")
      end
    end
  end
end
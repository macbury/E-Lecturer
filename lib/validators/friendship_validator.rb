# encoding: UTF-8
class FriendshipValidator < ActiveModel::Validator
  
  def validate(record)
    check_array = []
    check_array << record.user.mode unless record.user.nil?
    check_array << record.friend.mode unless record.friend.nil?

    if check_array.uniq.size < 2
      record.errors[:user_id] << I18n.t("errors.friendship.student", default: "połączenie musi być między wykładowcą a studentem")
    end

    record.errors[:user_id] << I18n.t("errors.friendship.not_same", default: "nie może być to samo") if record.friend_id == record.user_id

    if !record.user.nil? && !record.friend.nil?
      if record.friend.lecturer?
        access_tokens = record.friend.access_tokens
      else
        access_tokens = record.user.access_tokens
      end

      at = access_tokens.where(code: record.access_token).first

      if at.nil?
        record.errors[:access_token] << I18n.t("errors.friendship.no_access_token", default: "jest nieprawidłowy")
      elsif at.expired?
        record.errors[:access_token] << I18n.t("errors.friendship.expired", default: "wygasł")
      end
    end
  end
end
# encoding: UTF-8
class FriendshipValidator < ActiveModel::Validator
  
  def validate(record)
    record.errors[:student_id] << I18n.t("errors.friendship.student", default: "musi być wykładowcą") if record.student.nil? || !record.student.student?
    record.errors[:lecturer_id] << I18n.t("errors.friendship.lecturer", default: "musi być studentem") if record.lecturer.nil? || !record.lecturer.lecturer?
    
    record.errors[:student_id] << I18n.t("errors.friendship.not_same", default: "nie może być to samo") if record.student_id == record.lecturer_id

    if !record.user.nil?
      at = record.lecturer.access_tokens.where(code: at.access_token).first

      if at.nil?
        record.errors[:access_token] << I18n.t("errors.friendship.no_access_token", default: "jest nieprawidłowy")
      elsif at.expired?
        record.errors[:access_token] << I18n.t("errors.friendship.expired", default: "wygasł")
      end
    end
  end
end
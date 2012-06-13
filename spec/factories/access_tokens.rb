# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :access_token do
    user
    code { |index| "token#{index}" }
    expire_at 2.days.from_now
  end

  factory :access_token_for_form, class: AccessToken do
    expire_at 2.days.from_now
  end
end

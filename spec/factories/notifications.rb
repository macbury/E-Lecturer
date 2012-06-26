# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    user_id 1
    action_key "MyString"
    message "MyText"
    notifiable_type "MyString"
    notifiable_id "MyString"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stream do
    user_id 1
    lecturer_id 1
    streamable_id 1
    streamable_type "MyString"
  end
end

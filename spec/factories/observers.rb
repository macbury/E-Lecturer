# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :observer do
    observable_type "MyString"
    observable_id 1
    user_id 1
  end
end

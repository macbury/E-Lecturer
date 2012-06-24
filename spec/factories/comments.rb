# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    sequence(:body) { |index| "Komentarz numer #{index}" }
  end
end

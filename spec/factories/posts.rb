# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    sequence(:body) { |index| "Wiadomosc numer #{index}" }
  end
end

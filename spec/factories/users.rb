# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    mode User::Undefined
    sequence(:email) {|n| "user#{n}@test.local" }
    password "foobar1"
    password_confirmation "foobar1"
  end

  factory :lecturer, class: User do
    mode User::Lecturer
    sequence(:email) {|n| "lecturer#{n}@test.local" }
    password "foobar1"
    password_confirmation "foobar1"
    first_name  { |index| "Elvis#{1}" }
    last_name   { |index| "Presley#{1}" }
    screen_name { |index| "screen.name#{1}" }
  end
end

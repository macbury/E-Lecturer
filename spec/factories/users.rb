

FactoryGirl.define do
  factory :user do
    mode User::Undefined
    sequence(:username) {|n| "user#{n}" }
    sequence(:email) {|n| "user#{n}@test.local" }
    password "foobar1"
    picture nil
    password_confirmation "foobar1"
  end

  factory :lecturer, class: User do
    mode User::Lecturer
    sequence(:email) {|n| "lecturer#{n}@test.local" }
    picture nil
    password "foobar1"
    password_confirmation "foobar1"
    
    sequence(:first_name) {|n| "Arek#{n}" }
    sequence(:last_name) {|n| "Buras#{n}" }
    sequence(:screen_name) {|n| "screen.#{n}" }
    sequence(:username) {|n| "lecturer#{n}" }
  end
end

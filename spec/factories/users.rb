require 'factory_girl'

FactoryGirl.define do
  factory :user do
    factory :session_user do
      email "test@test.com"
      password "password"
    end
    name "Eric Santos"
    email "test@test.com"
    password "password"
    password_confirmation "password"
    age 23
    language "spanish"
  end
end

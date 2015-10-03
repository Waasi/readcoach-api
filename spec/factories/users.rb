require 'factory_girl'

FactoryGirl.define do
  factory :user do
    name "Eric Santos"
    email "test@test.com"
    password "password"
    password_confirmation "password"
    age 23
    language "spanish"
  end
end

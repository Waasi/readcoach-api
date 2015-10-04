# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  age                    :integer
#  language               :string
#  token                  :string
#

require 'factory_girl'
require 'faker'

FactoryGirl.define do
  factory :user do
    factory :session_user do
      email "test@test.com"
      password "password"
    end
    name "Eric Santos"
    email Faker::Internet.email
    password "password"
    password_confirmation "password"
    age 23
    language "spanish"
  end
end

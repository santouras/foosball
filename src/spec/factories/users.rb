# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    points 500
  end
end

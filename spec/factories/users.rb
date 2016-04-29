FactoryGirl.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    display_name { FFaker::Name.name }
    points 500
  end
end

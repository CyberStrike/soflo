require 'ffaker'

FactoryGirl.define do  factory :location_event do
    location nil
event nil
  end

  factory :location do
    name "MyString"
    streetnumber "MyString"
    street "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
    country "MyString"
  end

  factory :user do
    email{Faker::Internet.free_email}
    password{Faker::Internet.password(min_length=8)}
  end

  factory :event do
    title{Faker::Name.first_name}
    start{(DateTime.now + rand(100).days - rand(24).hours).at_beginning_of_minute}
    finish{(DateTime.now + rand(100).days - rand(24).hours).at_beginning_of_minute}
    description{Faker::Lorem.paragraph}
  end

end
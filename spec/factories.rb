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
    email{FFaker::Internet.free_email}
    password{FFaker::Internet.password(min_length=8)}
  end

  factory :event do
    title{FFaker::Name.first_name}
    start{(DateTime.now + rand(100).days - rand(24).hours).at_beginning_of_minute}
    finish{(DateTime.now + rand(100).days - rand(24).hours).at_beginning_of_minute}
    description{FFaker::Lorem.paragraph}
  end

end
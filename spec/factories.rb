require 'ffaker'

FactoryGirl.define do

  factory :user do
    email{Faker::Internet.free_email}
    password{Faker::Internet.password(min_length=8)}
  end

  factory :event do
    title{Faker::Name.first_name}
    start{DateTime.now + rand(100).days}
    finish{DateTime.now + rand(100).days}
    description{Faker::Lorem.paragraph}
  end

end
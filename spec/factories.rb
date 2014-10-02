require 'ffaker'


FactoryGirl.define do

  factory :event do
    title{Faker::Name.first_name}
    start{DateTime.now + rand(100).days}
    finish{DateTime.now + rand(100).days}
    description{Faker::Lorem.paragraph}
  end

end
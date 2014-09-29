require 'ffaker'

FactoryGirl.define do

  factory :event do
    title Faker::Name.first_name
    start Time.now
    finish Time.now
    description Faker::Lorem.paragraph
  end


end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'ffaker'
require 'factory_girl'
#
# FactoryGirl.define do
#
#   factory :event do
#     title{Faker::Name.first_name}
#     start{DateTime.now + rand(100).days}
#     finish{DateTime.now + rand(100).days}
#     description{Faker::Lorem.paragraph}
#   end
#
# end


100.times do
  FactoryGirl.create :event
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl'

def create_event(user)

  100.times do
    FactoryGirl.create :event, {user: user}
  end

  puts "\n100 Events Seeded for #{user.email} \n"

end

def seed_events

  user = User.all.sample(1).first

  if user

    create_event(user)

  else

    puts "\nCould not find an existing user"

    user = FactoryGirl.create :user, {email: 'user@example.com', password: '1234567890'}

    puts "\nCreated u: #{user.email}, p: #{user.password}"

    create_event(user)

  end

end

seed_events
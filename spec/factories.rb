require 'ffaker'

FactoryGirl.define do

  factory :organization do
            name{ FFaker::Conference.name }
           about{ FFaker::Lorem.paragraph }
             url{ FFaker::Internet.http_url}
  end

  factory :location_event do
    location nil
    event nil
  end

  factory :location do
            name{ FFaker::Company.name }
    streetnumber{ rand(9999) }
          street{ FFaker::AddressUS.street_name }
            city{ FFaker::AddressUS.city }
           state{ FFaker::AddressUS.state_abbr }
             zip{ FFaker::AddressUS.zip_code }
          country 'US'
    long_address{ "#{streetnumber} #{street} #{city} #{state}" }
  end

  factory :user do
          email{ FFaker::Internet.free_email }
       password{ FFaker::Internet.password(min_length=8) }
  end

  factory :event do
          title{ FFaker::Name.first_name }
          start{ (DateTime.now + rand(100).days - rand(24).hours).at_beginning_of_minute }
         finish{ (DateTime.now + rand(100).days - rand(24).hours).at_beginning_of_minute }
    description{ FFaker::Lorem.paragraph }
       location{ FactoryGirl.create :location  }
  end

end
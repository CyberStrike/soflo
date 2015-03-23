class LocationEvent < ActiveRecord::Base
  belongs_to :location
  belongs_to :event

  accepts_nested_attributes_for :location
end

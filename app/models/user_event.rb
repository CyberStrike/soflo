class UserEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user, presence: true
end

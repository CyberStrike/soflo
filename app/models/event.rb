class Event < ActiveRecord::Base

  before_create :initialize_user_event

  has_one :user_event, dependent: :destroy
  has_one :user, through: :user_event
  accepts_nested_attributes_for :user_event # Create User Event at same time

  has_one :location_event, dependent: :destroy
  has_one :location, through: :location_event
  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :location_event

  validates :title,
            presence: true,
            length:{  minimum: 2}
  validates :description,
            presence: true,
            length:{  minimum: 2}
  validates :start,
            presence: true
  validate :start_time_not_in_past
  validates :finish,
            presence: true

  scope :this_week, -> { where(:start => Date.current.beginning_of_week..Date.current.end_of_week ) }

  def startdate
    start.to_date
  end

  def starttime
    start.strftime('%H:%M')
  end

  private

  def start_time_not_in_past
    if start
      if self.start < DateTime.now - 1.hour
        errors.add :start, 'No Time Traveling Allowed'
      end
    end
  end

  def initialize_user_event
    build_user_event(user: self.user)
  end

end
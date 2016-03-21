class Event < ActiveRecord::Base

  before_create :initialize_user_event
  before_validation :set_finish_date, on: [:create, :update]

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

  validate  :start_time_not_in_past

  validate  :finish_time_in_future

  validates :finish,
            presence: true

  scope :this_week, -> { where(:start => Date.current.beginning_of_week..Date.current.end_of_week ) }

  def start_date
    start.to_date
  end

  def start_time
    start.strftime('%H:%M')
  end
  def finish_date
    finish.to_date
  end

  def finish_time
    finish.strftime('%H:%M')
  end


  # Set Finish Date to Start Date with Time Zone
  # Or else we time travel which is bad.
  def set_finish_date
    if self.start.to_date != self.finish.to_date
      finish_time = self.start.to_date.to_s + ' ' + self.finish.strftime('%I:%M %p')
      self.finish = Time.zone.parse(finish_time)
    end
  end

  private

  def start_time_not_in_past
    if start
      if self.start < DateTime.now - 1.hour
        errors.add :start, 'No Time Traveling Allowed'
      end
    end
  end

  def finish_time_in_future
    if finish
      if self.finish < self.start
        errors.add :finish, 'An Event Cannot Finish Before It Has Started.'
      end
    end
  end

  def initialize_user_event
    build_user_event(user: self.user)
  end

end
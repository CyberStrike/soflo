class Event < ActiveRecord::Base


  validates :title,
            presence: true,
            length:{minimum: 2}
  validates :description,
            presence: true,
            length:{minimum: 2}
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

end

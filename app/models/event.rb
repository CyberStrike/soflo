class Event < ActiveRecord::Base

  validates :title, presence: true, length:{minimum: 2}
  validates :description, presence: true, length:{minimum: 2}
  validates :start, presence: true
  validate :valid_start
  validates :finish, presence: true
  validate :valid_finish


  def time
    date.strftime("%I:%M %P")
  end

  def date2
    date.strftime("%m/%d/%Y")
  end

  private

  def valid_start

    case
      when start.class != Time
        false
      when start.empty?
        false
      when start < Time.now
        false
      else
        true
    end

  end

  def valid_finish

    case
      when finish.class != DateTime
        false
      when finish < self.start
        false
      else
        true
    end

  end
end

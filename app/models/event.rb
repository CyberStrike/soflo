class Event < ActiveRecord::Base

  validates :title, presence: true, length:{minimum: 2}
  validates :description, presence: true, length:{minimum: 2}
  validates :start, presence: true
  validate :valid_start


  def time
    date.strftime("%I:%M %P")
  end

  def date2
    date.strftime("%m/%d/%Y")
  end

  private

  def valid_start

    case
      when self.start.class != Time
        false
      when self.start.empty?
        false
      when self.start < Time.now
        false
      else
        true
    end

  end

end

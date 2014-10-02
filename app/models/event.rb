class Event < ActiveRecord::Base

  validates :title, presence: true, length:{minimum: 2}
  validates :description, presence: true, length:{minimum: 2}
  validates :start, presence: true
  validates :finish, presence: true


  def startdate
    start.to_date
  end

  def starttime
    start.strftime("%H:%M")
  end

end

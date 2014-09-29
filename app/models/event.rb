class Event < ActiveRecord::Base

  validates :description, presence: true, length:{minimum: 2}



  def time
    date.strftime("%I:%M %P")
  end

  def date2
    date.strftime("%m/%d/%Y")
  end
end

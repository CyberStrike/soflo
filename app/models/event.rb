class Event < ActiveRecord::Base
  def time
    date.strftime("%I:%M %P")
  end

  def date2
    date.strftime("%m/%d/%Y")
  end
end

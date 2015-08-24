class Organization < ActiveRecord::Base
  before_create :check_url

  def check_url
    if MeetupApi.is_meetup_url(url)
      group = MeetupApi.group(url)
      self.name = group['name']
      self.about = group['description']
      self.meetup_id = group['id']
    end
  end
end

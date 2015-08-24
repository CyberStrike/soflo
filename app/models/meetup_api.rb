class MeetupApi
  BASE_URL = 'https://api.meetup.com'
  AUTH = "sign=true&key=#{ENV['MEETUP_KEY']}"

  def self.is_meetup_url(url)
    url =~ /meetup.com/
  end

  def self.group(url)
    group_name = URI.parse(url).path.split('/').second
    url = "#{BASE_URL}/#{group_name}?#{AUTH}"
    response = HTTParty.get(url)

    # watch out for the rate limit
    #p response.headers

    response.parsed_response
  end
end

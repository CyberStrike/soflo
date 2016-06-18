json.array!(@events_by_week.first[1]) do |event|
  json.extract! event, :id, :title, :start, :finish
  json.url event_url(event, format: :json)
end

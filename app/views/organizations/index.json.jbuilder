json.array!(@organizations) do |organization|
  json.extract! organization, :id
  json.url organization_url(organization, format: :json)
end

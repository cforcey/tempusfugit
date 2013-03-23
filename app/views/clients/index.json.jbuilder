json.array!(@clients) do |client|
  json.extract! client, :name, :description, :user_id, :hourly_rate, :notes
  json.url client_url(client, format: :json)
end
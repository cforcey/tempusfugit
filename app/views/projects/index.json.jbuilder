json.array!(@projects) do |project|
  json.extract! project, :name, :description, :user_id, :client_id, :hourly_rate, :notes
  json.url project_url(project, format: :json)
end
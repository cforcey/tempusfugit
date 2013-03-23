json.array!(@spans) do |span|
  json.extract! span, :name, :description, :user_id, :project_id, :start_at, :end_at, :billable, :invoiced_at, :notes
  json.url span_url(span, format: :json)
end
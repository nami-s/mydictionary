json.extract! schedule, :id, :title, :description, :start, :end, :created_at, :updated_at
json.url schedule_url(schedule, format: :json)

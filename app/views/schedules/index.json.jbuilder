json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :title, :description
  json.start schedule.start
  json.end schedule.end
end

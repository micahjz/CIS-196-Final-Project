json.array!(@meetings) do |meeting|
  json.extract! meeting, :id, :starts_at, :students_tutor_id
  json.url meeting_url(meeting, format: :json)
end

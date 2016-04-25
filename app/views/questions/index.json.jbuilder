json.array!(@questions) do |question|
  json.extract! question, :id, :text, :students_tutor_id
  json.url question_url(question, format: :json)
end

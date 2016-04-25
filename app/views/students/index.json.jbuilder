json.array!(@students) do |student|
  json.extract! student, :id, :name, :password_hash, :email
  json.url student_url(student, format: :json)
end

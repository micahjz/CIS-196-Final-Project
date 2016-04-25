json.array!(@tutors) do |tutor|
  json.extract! tutor, :id, :name, :password_hash, :email, :field
  json.url tutor_url(tutor, format: :json)
end

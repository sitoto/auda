json.array!(@users) do |user|
  json.extract! user, 
  json.url cpanel_user_url(user, format: :json)
end

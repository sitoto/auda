json.array!(@resources) do |resource|
  json.extract! resource, :name, :note
  json.url resource_url(resource, format: :json)
end

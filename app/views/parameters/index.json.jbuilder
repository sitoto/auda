json.array!(@parameters) do |parameter|
  json.extract! parameter, :code, :name, :value, :position
  json.url parameter_url(parameter, format: :json)
end

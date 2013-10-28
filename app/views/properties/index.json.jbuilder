json.array!(@properties) do |property|
  json.extract! property, :code, :name, :value, :position
  json.url property_url(property, format: :json)
end

json.array!(@products) do |product|
  json.extract! product, :status, :user_name, :ip
  json.url product_url(product, format: :json)
end

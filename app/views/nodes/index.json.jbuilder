json.array!(@nodes) do |node|
  json.extract! node, :name, :position
  json.url node_url(node, format: :json)
end

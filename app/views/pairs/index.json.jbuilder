json.array!(@pairs) do |pair|
  json.extract! pair, :category_id, :csvfile_id, :hash_paris, :status
  json.url pair_url(pair, format: :json)
end

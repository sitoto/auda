json.array!(@csvfiles) do |csvfile|
  json.extract! csvfile, :name, :creater, :size
  json.url csvfile_url(csvfile, format: :json)
end

json.array!([@stream]) do |json, stream|
  json.(stream, :id, :created_at)
  json.html stream.decorator.html
end
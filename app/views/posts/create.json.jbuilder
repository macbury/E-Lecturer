

json.stream do |json|
  json.(@post.stream, :id, :created_at)
  json.html @post.stream.decorator.html
end
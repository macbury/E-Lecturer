json.comment do |json|
  json.(@comment, :id, :created_at)
  json.html @comment.decorator.html
end
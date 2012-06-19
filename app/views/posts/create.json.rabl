node :form do
  render_to_string(partial: "form", locals: { post: Post.new })
end

node :stream do
  extends "timelines/stream"
end
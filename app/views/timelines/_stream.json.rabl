object @stream
attributes :id, :created_at, :published_at, :streamable_type

node(:html) do |stream|
  render_to_string(partial: stream.streamable, locals: { stream: stream }, formats: [:html])
end
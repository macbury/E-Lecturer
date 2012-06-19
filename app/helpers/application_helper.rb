module ApplicationHelper
  def with_format(format, &block)
    old_formats = formats
    self.formats = [format]
    result = block.call
    self.formats = old_formats
    result
  end
end

# encoding: utf-8

class UserPosterUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper
  storage :file

  after :remove, :delete_empty_upstream_dirs

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{get_last_dir_part(model.id)}"
  end

  def get_last_dir_part(modelid)
    p = modelid.to_s.rjust(9, '0')
    "#{p[0,3]}/#{p[3,3]}/#{p[6,3]}"
  end

  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path)
  rescue SystemCallError
    true
  end

  def default_url
    asset_path("posters/#{version_name}.gif")
  end

  version :thumbnail do
    process :resize_to_fill => [50, 50]
  end
  version :poster do
    process :resize_to_fill => [150, 200]
  end
  version :sidebar do
    process :resize_to_fill => [480, 320]
  end
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end

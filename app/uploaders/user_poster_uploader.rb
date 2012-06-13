# encoding: utf-8

class UserPosterUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
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
    Dir.delete(path) # fails if path not empty dir
  rescue SystemCallError
    true # nothing, the dir is not empty
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    asset_path("posters/#{version_name}.gif")
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumbnail do
    process :resize_to_fill => [50, 50]
  end
  version :poster do
    process :resize_to_fill => [150, 200]
  end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end

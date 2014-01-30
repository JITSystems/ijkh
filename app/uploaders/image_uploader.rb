# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  # storage :file
  storage :fog

  def store_dir
    '/home/ubuntu/apps/shared/images'
  end

end

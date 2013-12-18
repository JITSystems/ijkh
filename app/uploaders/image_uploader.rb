# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    '/home/ubuntu/apps/shared/images'
  end

end

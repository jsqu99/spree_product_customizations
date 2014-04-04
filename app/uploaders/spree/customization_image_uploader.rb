require 'carrierwave'

module Spree
  class CustomizationImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    version :thumb do
      process :resize_to_fill => [50, 50]
    end
  end
end

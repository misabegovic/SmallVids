class VideoUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(
      webm
      mp4
      mp3
      flv
      f4v
      f4p
      f4a
      f4b
      3g2
      3gp
      svi 
      m4v
      mpg
      mp2
      mpeg
      mpe
      mpv
      m4p
      amv
      asf
      wmv
      mov
      qt
      gifv
      mkv
    )
  end
end

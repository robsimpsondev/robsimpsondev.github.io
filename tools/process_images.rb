# frozen_string_literal: true
require "rmagick"
require "byebug"

# config

PROJECT_ROOT = "#{__dir__}/.."
SITE_DIR     = "#{PROJECT_ROOT}/docs"

IMAGE_SOURCE_DIR     = "#{SITE_DIR}/assets/images/originals"
IMAGE_SOURCE_FORMATS = ["*.jpg"].freeze

IMAGE_TARGET_DIR     = "#{SITE_DIR}/assets/images/processed"
IMAGE_TARGET_FORMATS = ["jpg", "webp"].freeze
IMAGE_TARGET_WIDTHS  = [2560, 1920, 1280].freeze # 4k (most monitors and high end tablets), 1080p (most high end smart phones), 720p (most smart phones); see https://screensiz.es/.

IMAGE_TARGET_PARAMETERS = {
  "*.jpg"  => {},
  "*.webp" => {},
}

# appendix

JPEG_ATTRIBUTE = {
  width:  "exif:ImageWidth",
  length: "exif:ImageLength",
}

def aspect_ratio(image)
  image[JPEG_ATTRIBUTE[:width]].to_f/image[JPEG_ATTRIBUTE[:length]].to_f
end

def image_name(image)
  image.filename.split("/").last.split(".")[0..-2].join(".")
end

# main

include Magick

source_image_paths = Dir.glob("#{IMAGE_SOURCE_DIR}/*.jpg")

ImageList.new(*source_image_paths).each do |source_image|
  IMAGE_TARGET_FORMATS.each do |target_format|
    IMAGE_TARGET_WIDTHS.each do |target_width|
      if target_width <= source_image[JPEG_ATTRIBUTE[:width]].to_i
        target_height = target_width/aspect_ratio(source_image)
        new_image = source_image.resize(target_width, target_height)

        filename = "#{IMAGE_TARGET_DIR}/#{image_name(source_image)}_#{target_width}x#{target_height.to_i}.#{target_format}"

        puts "Writing #{filename}"
        new_image.write(filename)  # rmagick does the format conversion based on filename
      end
    end
  end
end

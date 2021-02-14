# frozen_string_literal: true
require "rmagick"

PROJECT_ROOT = "#{__dir__}/../"
SITE_DIR     = "#{PROJECT_ROOT}/docs/"

IMAGE_SOURCE_DIR     = "#{SITE_DIR}/assets/images/originals/"
IMAGE_SOURCE_FORMATS = ["*.jpg"].freeze

IMAGE_TARGET_DIR     = "#{SITE_DIR}assets/images/processed/"
IMAGE_TARGET_FORMATS = ["*.jpg", "*.webp"].freeze
IMAGE_TARGET_WIDTHS  = [2560, 1920, 1280].freeze # 4k (most monitors and high end tablets), 1080p (most high end smart phones), 720p (most smart phones); see https://screensiz.es/.

IMAGE_TARGET_PARAMETERS = {
  "*.jpg"  => {},
  "*.webp" => {},
}

puts Dir.entries(IMAGE_SOURCE_DIR)

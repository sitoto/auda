require 'carrierwave/mongoid'

CarrierWave.configure do |config|
  config.storage = :grid_fs
  config.root = Rails.root.join('tmp')
  config.cache_dir = "uploads"

end
#CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/


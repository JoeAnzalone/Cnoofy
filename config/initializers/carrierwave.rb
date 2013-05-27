CarrierWave.configure do |config|
  config.cache_dir = Rails.root.join('tmp/uploads')
  if ENV["S3_ENABLE"]
    config.storage = :fog
    config.fog_credentials = {
        :provider               => 'AWS',
        :aws_access_key_id      => ENV["S3_KEY"],
        :aws_secret_access_key  => ENV["S3_SECRET"],
        :region                 => ENV["S3_REGION"]
    }
    config.fog_directory = ENV["S3_BUCKET"]
  else
    config.storage = :file
  end
end
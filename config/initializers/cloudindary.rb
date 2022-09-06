Cloudinary.config do |config|
  config.cloud_name = Rails.application.credentials.dig(:development, :cloudinary, :cloud_name)
  config.api_key = Rails.application.credentials.dig(:development, :cloudinary, :api_key)
  config.api_secret = Rails.application.credentials.dig(:development, :cloudinary, :api_secret)
  config.secure = true
end

if Rails.env.production?
  Sunlight::Base.api_key = ENV['SUNLIGHT_BASE_API']
else
  Sunlight::Base.api_key = SUNLIGHT_BASE_API
end
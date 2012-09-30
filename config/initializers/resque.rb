require 'resque'
# if Rails.env.production?
#   redis_url = ENV["REDISTOGO_URL"]
#   uri = URI.parse(redis_url)
#   REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
# else
#   REDIS = Redis.new
# end
# Resque.redis = REDIS

if Rails.env.development?
  uri = URI.parse(ENV["REDISTOGO_URL"])
  Resque.redis = Redis.new(:host => 'localhost', :port => '6379')
else
  uri = URI.parse(ENV["REDISTOGO_URL"])
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end
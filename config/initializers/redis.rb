if Rails.env.development?
  REDIS = Redis.new(:host => 'localhost', :port => 6379)
  Resque.redis = REDIS
else
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  Resque.redis = REDIS  
end
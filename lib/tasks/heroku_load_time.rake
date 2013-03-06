desc "pings oursolution.is every 10 minutes"
task :pings do
  require 'net/http'
  require 'uri'
  Net::HTTP.get URI("http://oursolution.is")
end
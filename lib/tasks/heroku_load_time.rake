desc "pings oursolution.is every 10 minutes"
task :pings do
  require 'net/http'
  uri = URI("http://oursolution.is")
  Net::HTTP.get_response(uri)
end
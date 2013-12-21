desc "pings oursolution.is every 10 minutes"
task :pings => :environment do
  puts "oursolution.is must not idle"
  require 'net/http'
  uri = URI("http://oursolution.is")
  Net::HTTP.get_response(uri)
end
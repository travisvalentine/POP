  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'mechanize'
  # require 'cgi'

  agent = Mechanize.new

  # get the escapes page with Mechanize
  mayor_index = agent.get("http://usmayors.org/meetmayors/mayorsatglance.asp")
  puts mayor_index

  # find links with /escapes and iterate over each escape
#   escapes_index.links_with(:href => %r{/escapes/}).each do |escape|
#     escape_page = escape.click

#     # parse Mechanize'd escape with Nokogiri
#     escape_doc = Nokogiri::HTML(open(escape_page.uri))
#     escape_title = escape_doc.css('title').text.split(" - ").first.strip
#     escape_location = escape_doc.css('.deal-title p').text.split(%r{\W{2,}}).first
#     escape_details = escape_doc.css('.highlights ul li').text.gsub("\n","--")
#     escape_price = escape_doc.css('.deal-price').text.gsub("\n","").strip
#     escape_phone = escape_doc.css('.meta .phone').text.gsub("|","")
#     escape_street = escape_doc.css('.meta .street_1').text.gsub("\n","--")
#     escape_city = escape_doc.css('.deal-title p').text.split(%r{\W{2,}})[-2]
#     escape_state = escape_doc.css('.deal-title p').text.split(",")[-1].strip
#     escape_zipcode = escape_doc.xpath("//br/following-sibling::text()").text.split(" ").last
#     escape_expiration = escape_doc.css('.fine-print p').text.split(%r{\b[A-Z]+\b}).last.strip

#     lat_long =  escape_doc.css('.directions a').map { |link| link['href'] }.join("").split("=")[-1]

#     escape_latitude = lat_long.split(",")[0].strip
#     if lat_long.split(",")[1].nil?
#       escape_longitude = nil
#     else
#       escape_longitude = lat_long.split(",")[1].strip
#     end

#     # Persist Escape from scraped data
#     db_escape = Escape.find_or_initialize_by_title(escape_title)
#     db_escape.location = escape_location
#     db_escape.details = escape_details
#     db_escape.price = escape_price
#     db_escape.phone = escape_phone
#     db_escape.street = escape_street
#     db_escape.city = escape_city
#     db_escape.state = escape_state
#     db_escape.zipcode = escape_zipcode
#     db_escape.expiration = escape_expiration.to_date
#     db_escape.latitude = escape_latitude
#     db_escape.longitude = escape_longitude
#     db_escape.save
#   end
# end

desc "Scrape the National Governors Association"
task :governors => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'mechanize'

  agent = Mechanize.new

  nga_home = agent.get("http://www.nga.org/cms/governors/bios")

  nga_home.links_with(:href => %r{/cms/home/governors/current-governors/col2-content/main-content-list/}).each do |link|
    governor_page = link.click

    governor_bio = Nokogiri::HTML(open(governor_page.uri))
    gov_name = governor_bio.css(".article-title").text
    gov_info = governor_bio.css("ul.bio-stats-list").text

    puts gov_name
    puts gov_info
  end

end
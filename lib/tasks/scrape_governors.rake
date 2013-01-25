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

    governor_bio  = Nokogiri::HTML(open(governor_page.uri))
    heading       = governor_bio.css(".article-title").text
    gov_title     = heading.split(" ").reject{|a| a == "Governor"}
    gov_party     = governor_bio.css("ul.bio-stats-list li:nth-child(3)").last.text.gsub(/\s+/, "").split(":").last

    if gov_title.length == 3
      gov_state      = gov_title.first
      gov_first_name = gov_title[-2]
      gov_last_name  = gov_title[-1]
    elsif gov_title.length == 4
      gov_state      = gov_title[0..1].join(" ")
      gov_first_name = gov_title[-2]
      gov_last_name  = gov_title[-1]
    elsif gov_title.length == 5
      gov_state      = gov_title[0..1].join(" ")
      gov_first_name = gov_title[-2]
      gov_last_name  = gov_title[-1]
    elsif gov_title.length == 6
      gov_state      = gov_title[0..1].join(" ")
      gov_first_name = gov_title[-4]
      gov_last_name  = gov_title[-3..-1].join(" ")
    else
      gov_state      = "state"
      gov_first_name = "first"
      gov_last_name  = "last"
    end

    # Save Governors to DB

    # Note: some of the logic above still doesn't parse
    # Govs properly, particularly those with initials, suffixes, etc.
    # so it's best to run this once without persisting so you know what's up
    # and can go back into the DB and fix accordingly when you run it
    # and persist the data
    puts "Scraping #{gov_first_name} #{gov_last_name}"

    db_gov = Politician.create!(
               title:        "Governor",
               first_name:   gov_first_name,
               last_name:    gov_last_name,
               party:        gov_party,
               short_title:  "Gov",

               # Turn off validation on fec_id for scraping
               # Currently fec_id is checked for uniqueness
               # but we don't scrape that
               fec_id:       nil
            )
  end

end
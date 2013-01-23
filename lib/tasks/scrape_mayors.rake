desc "Scrape the US Conference of Mayors"
task :mayors => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'mechanize'

  agent = Mechanize.new

  agent.get("http://usmayors.org/meetmayors/mayorsatglance.asp")

  form = agent.page.forms.last
  form.field_with(:name => "State").options.each do |state|
    state.select
    form.submit
    tables = agent.page.search("table.pagesSectionBodyTightBorder")
    tables.each do |mayor|
      puts mayor.css("a")
      puts mayor.css("td:first-child").search('strong').xpath('text()')
      puts mayor.css("img").last
    end
  end

end
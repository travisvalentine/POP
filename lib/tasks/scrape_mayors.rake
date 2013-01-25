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
      # puts mayor.css("a")
      # puts mayor.css("img").last
      mayor_data        = mayor.css("td:first-child").search('strong').xpath('text()').first.text
      mayor_name        = mayor_data.split(" ")
      # mayor_city_state  = mayor_data.last

      if mayor_name.length == 2
        mayor_name = mayor_name.join(" ")
        mayor_name = mayor_data.split(" ")
        mayor_first_name = mayor_name[0]
        mayor_last_name  = mayor_name[1]
      elsif mayor_name.length == 3
        mayor_name = mayor_name.join(" ")
        mayor_name = mayor_data.split(".")
        mayor_first_name = mayor_name[0]
        mayor_last_name  = mayor_name[1..-1].join(" ")
      elsif mayor_name.length >= 4
        mayor_first_name = mayor_name[0]
        mayor_last_name  = mayor_name[1..-1].join(" ")
      else
        mayor_first_name = "first"
        mayor_last_name  = "last"
      end

      # Save Mayors to DB
      puts "Scraping #{mayor_name}: #{mayor_first_name} #{mayor_last_name}"

      mayor = Politician.create!(
                title:        "Mayor",
                first_name:   mayor_first_name,
                last_name:    mayor_last_name,
                party:        nil,
                short_title:  "Mayor",

                # Turn off validation on fec_id for scraping
                # Currently fec_id is checked for uniqueness
                # but we don't scrape that
                fec_id:       nil
              )
    end
  end

end
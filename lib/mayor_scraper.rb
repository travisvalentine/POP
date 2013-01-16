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
    puts mayor.text
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Profile.delete_all
User.delete_all

# Mary profile
mary_profile = Profile.create(first_name: 'Mary', last_name: 'Cutrali', birthday: '1990-07-29', bio: 'hacktastic', twitter: 'marycutrali', job_title: 'hacker', party_affiliation: 'Republican')
# Mary user
mary = User.create(:email => 'mary.cutrali@gmail.com', :password => 'mary', :profile => mary_profile)
    
# Travis profile
travis_profile = Profile.create(first_name: 'Travis', last_name: 'Valentine', birthday: '1983-03-16', bio: 'stuff', twitter: 'travisvalentine', job_title: 'hacker', party_affiliation: 'Democrat')
# Travis user
travis = User.create(:email => 'tvalent2@gmail.com', :password => 'travis', :profile => travis_profile)

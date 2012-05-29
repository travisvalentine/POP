# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# delete
Profile.delete_all
User.delete_all
Issue.delete_all
Problem.delete_all
Solution.delete_all

# Mary profile
mary_profile = Profile.create(first_name: 'Mary', last_name: 'Cutrali', birthday: '1990-07-29', bio: 'hacktastic', twitter: 'marycutrali', job_title: 'hacker', party_affiliation: 'Republican')
# Mary user
mary = User.create(:email => 'mary.cutrali@gmail.com', :password => 'mary', :profile => mary_profile)
    
# Travis profile
travis_profile = Profile.create(first_name: 'Travis', last_name: 'Valentine', birthday: '1983-03-16', bio: 'stuff', twitter: 'travisvalentine', job_title: 'hacker', party_affiliation: 'Democrat')
# Travis user
travis = User.create(:email => 'tvalent2@gmail.com', :password => 'travis', :profile => travis_profile)

# Mary Problems/Solutions
mary_one = mary.problems.new(:body => "Government takes too long")
one_solution = mary_one.solutions.new(:body => "Open it up to collaboration")
mary_one.save
one_solution.update_attributes(problem_id: mary_one.id, user_id: mary.id)

mary_two = mary.problems.new(:body => "Politicians complain too much")
two_solution = mary_two.solutions.new(:body => "Force them to focus on solutions")
mary_two.save!
two_solution.update_attributes(problem_id: mary_two.id, user_id: mary.id)

# Travis Problems/Solutions
travis_three = travis.problems.new(:body => "Defense spending isn't questioned")
three_solution = travis_three.solutions.new(:body => "Refocus on smart military")
travis_three.save!
three_solution.update_attributes(problem_id: travis_three.id, user_id: travis.id)

travis_four = travis.problems.new(:body => "People's voices are rarely recorded")
four_solution = travis_four.solutions.new(:body => "Build a system that fixes that")
travis_four.save!
four_solution.update_attributes(problem_id: travis_four.id, user_id: travis.id)

# issues
ISSUES = %w(
  Civil\ Rights
  Defense
  Disabilities
  Economy
  Education
  Energy\ &\ Environment
  Ethics
  Fiscal\ Responsibility
  Foreign\ Policy
  Health\ Care
  Homeland\ Security
  Immigration
  Rural
  Seniors\ &\ Social\ Security
  Service
  Taxes
  Technology
  Urban\ Policy
  Veterans
  Women
)

ISSUES.each do |issue|
  Issue.create!(:name => issue)
end
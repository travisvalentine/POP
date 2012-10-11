class Politician < ActiveRecord::Base
  attr_accessible :title, :first_name, :last_name, :party, :twitter

  has_many :politician_problems
  has_many :problems, :through => :politician_problems

  has_many :politician_users
  has_many :users, :through => :politician_users

end

class Issue < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :on => :create

  has_many :issue_problems
  has_many :problems, :through => :issue_problems

end

class Issue < ActiveRecord::Base

  validates :name, :presence => true, :on => :create

  has_many :issue_problems
  has_many :problems, :through => :issue_problems

end

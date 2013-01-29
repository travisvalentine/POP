class Issue < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :on => :create

  has_many :issue_problems
  has_many :problems, :through => :issue_problems

  def self.with_problems
    select { |issue| issue.has_problems? }[0..5]
  end

  def self.remaining
    select { |issue| issue.has_problems? }[6..-1]
  end

  def has_problems?
    problems.present?
  end

  def icon_class_name
    name.downcase.parameterize
  end

end

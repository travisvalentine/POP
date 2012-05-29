class Problem < ActiveRecord::Base

  validates :body, :presence => true

  belongs_to :user
  
  has_many :solutions

  has_many :issue_problems
  has_many :issues, :through => :issue_problems

  accepts_nested_attributes_for :solutions, :issues

  def print_solutions
    solutions = Solution.find_all_by_problem_id(self.id)
    solutions.collect do |solution|
      solution.body
    end
  end

  def solution
    solutions
  end

  def solution=(value)
    solutions = value
  end

  def issue
    issues.first
  end
  
end

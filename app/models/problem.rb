class Problem < ActiveRecord::Base
  attr_reader :print_solutions

  validates :body, :presence => true

  belongs_to :user
  
  has_many :solutions

  accepts_nested_attributes_for :solutions

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
  
end

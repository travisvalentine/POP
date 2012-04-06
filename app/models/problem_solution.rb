class ProblemSolution < ActiveRecord::Base
  belongs_to :problem
  belongs_to :solution
end

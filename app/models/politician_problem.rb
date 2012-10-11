class PoliticianProblem < ActiveRecord::Base
  attr_accessible :politician_id, :problem_id

  belongs_to :politician
  belongs_to :problem
end

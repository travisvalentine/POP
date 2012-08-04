class IssueProblem < ActiveRecord::Base
  attr_accessible :problem_id, :issue_id

  belongs_to :problem
  belongs_to :issue

end

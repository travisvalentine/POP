class Notification < ActiveRecord::Base
  attr_accessible :body, :related_object_id
  belongs_to :user

  def self.create_from_comment(comment_body, user_id, solution_id)
    solution = Solution.find(solution_id)
    user = solution.user
    user.notifications.create(:body => comment_body,
                              :related_object_id => solution_id)
  end

  def self.create_from_solution(comment_body, user_id, problem_id)
    problem = Problem.find(problem_id)
    user = problem.user
    user.notifications.create(:body => comment_body,
                              :related_object_id => problem_id)
  end

end

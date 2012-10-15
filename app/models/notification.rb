class Notification < ActiveRecord::Base
  attr_accessible :body, :notification_type, :related_object_id, :problem_id
  belongs_to :user

  def self.create_from_comment(comment_body, user_id, solution_id)
    solution = Solution.find(solution_id)
    problem_id = solution.problem.id
    user = solution.user
    user.notifications.create(:body => comment_body,
                              :notification_type => "comment",
                              :related_object_id => solution_id,
                              :problem_id => problem_id)
  end

  def self.create_from_solution(comment_body, user_id, problem_id)
    problem = Problem.find(problem_id)
    user = problem.user
    user.notifications.create(:body => comment_body,
                              :notification_type => "solution",
                              :related_object_id => problem_id,
                              :problem_id => problem.id)
  end

  def has_been_read?
    read == true
  end

end

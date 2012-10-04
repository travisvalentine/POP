module UsersHelper
  def current_user_problem?(problem)
    current_user.problems.include?(problem)
  end
end

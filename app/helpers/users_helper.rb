module UsersHelper
  def current_user_problem?(problem)
    current_user.problems.include?(problem)
  end

  def current_user_comment?(comment)
    current_user.comments.include?(comment)
  end
end

module ProblemsHelper
  def others_problems
    Problem.where("user_id != ?", current_user.id)
  end
end

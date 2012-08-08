class SolutionUpvotesController < ApplicationController
  def create
    @solution = Solution.find(params[:id])
    if current_user
      current_user.up_vote(@solution)
      redirect_to problem_path(@solution.problem), :notice => "Yay!"
    else
      redirect_to(login_path, :notice => "Please log in to continue")
    end
  end
end

class ProblemUpvotesController < ApplicationController
  def create
    @problem = Problem.find(params[:id])
    if current_user
      current_user.up_vote(@problem)
      redirect_to problem_path(@problem), :notice => "Yay!"
    else
      redirect_to(login_path, :notice => "Please log in to continue")
    end
  end
end

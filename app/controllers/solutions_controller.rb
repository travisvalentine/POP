class SolutionsController < ApplicationController
  layout "application"
  before_filter :load_problem, :except => :destroy
  before_filter :authenticate, :only => :destroy

  def create
    solution = @problem.solutions.new(params[:solution].merge(:user_id => current_user.id))
    if solution.save
      redirect_to @problem, :notice => 'Thanks for your solution'
    else
      redirect_to @problem, :alert => 'Unable to add solution'
    end
  end

  def edit
    solution = @problem.solutions.find(params[:id])
  end

  def destroy
    @problem = current_user.problems.find(params[:problem_id])
    solution = @problem.solutions.find(params[:id])
    solution.destroy
    redirect_to @problem, :notice => 'solution deleted'
  end

  private
    def load_problem
      @problem = Problem.find(params[:problem_id])
    end
end

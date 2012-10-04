class SolutionsController < ApplicationController
  before_filter :find_problem, :except => [:destroy, :create]
  before_filter :authenticate, :only => :destroy

  def new
    @problem = Problem.find(params[:id])
    @solution = @problem.solutions.new
  end

  def create
    @problem = Problem.find(params[:solution][:problem_id])
    @solution = @problem.solutions.new(params[:solution])
    respond_to do |format|
      if @solution.save
        @solution.update_attributes(problem_id: @problem.id, user_id: current_user.id)
        format.html { redirect_to(@problem, :notice => 'Solution was successfully created.') }
      else
        format.html { redirect_to(:back, :notice => "There was an error.") }
      end
    end

  end

  def edit
    solution = @problem.solutions.find(params[:id])
  end

  def destroy
    @problem = current_user.problems.find(params[:problem_id])
    solution = @problem.solutions.find(params[:id])
    solution.destroy
    redirect_to @problem, :notice => 'Solution deleted.'
  end

  private
    def find_problem
      @problem = Problem.find(params[:problem_id])
    end
end

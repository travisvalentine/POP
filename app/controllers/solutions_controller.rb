class SolutionsController < ApplicationController
  before_filter :authenticate
  before_filter :find_problem, :except => [:destroy, :create, :edit, :update]

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
    @solution = current_user.solutions.find(params[:id])
  end

  def update
    @solution = current_user.solutions.find(params[:id])
    if @solution.update_attributes(params[:solution])
      redirect_to problem_path(@solution.problem), :alert => 'Solution updated successfully.'
    else
      render :edit, :alert => 'There was an error. Please try again.'
    end
  end

  def destroy
    @solution = current_user.solutions.find(params[:id])
    @solution.destroy
    redirect_to @solution.problem, :notice => 'Solution deleted.'
  end

  private
    def find_problem
      @problem = Problem.find(params[:problem_id])
    end
end

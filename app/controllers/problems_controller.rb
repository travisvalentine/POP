class ProblemsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  def new
    @problem = Problem.new
  end

  def create
    @problem = current_user.problems.new(params[:problem])
    @solution = @problem.solutions.new(params[:problem][:solution])
    if @problem.save
      # @problem.issue_id = params[:problem][:issue_ids]
      @solution.save!
      @solution.update_attributes(problem_id: @problem.id, user_id: current_user.id)
      redirect_to(@problem, :notice => 'Problem was successfully created.')
    else
      render :action => "new"
    end
  end

  def index
    @problems = Problem.all
  end

  def show
    @problem = Problem.find(params[:id])
  end

end
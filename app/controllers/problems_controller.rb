class ProblemsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  def new
    @problem = Problem.new
  end

  def create
    @problem = current_user.problems.new(params[:problem])
    @solution = @problem.solutions.new(params[:problem][:solution])
    if @problem.save
      @solution.save!
      @solution.update_attributes(problem_id: @problem.id, user_id: current_user.id)
      redirect_to(@problem, :alert => 'Problem was successfully created.')
      post_to_twitter(@problem) if params[:tweet].present?
    else
      render :action => "new"
    end
  end

  def index
    @problems = Problem.votes.page(params[:page]).per(2)
  end

  def show
    @problem = Problem.find(params[:id])
  end

private

  def post_to_twitter(problem)
    message = "I just offered a solution to #{problem.issue.name}" +
              "  - #{problem_url(problem)}"
    current_user.post_to_twitter(message)
  end
end
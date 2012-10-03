class ProblemsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  def new
    @problem = Problem.new
    @solution = @problem.solutions.new
  end

  def create
    @problem = current_user.problems.new(params[:problem])
    @solution = @problem.solutions.new(params[:problem][:solution])
    if @problem.save
      @solution.save!
      @solution.update_attributes(
        problem_id: @problem.id,
        user_id:    current_user.id,
        original:   true
      )
      redirect_to(@problem, :notice => 'Problem was successfully created.')
      post_to_twitter(@problem) if params[:tweet].present?
    else
      render :action => "new"
    end
  end

  def index
    @problems = Problem.votes.page(params[:page]).per(10)
  end

  def show
    @problem = Problem.find(params[:id])
  end

private

  def post_to_twitter(problem)
    if problem.issue.present?
      message = "I just offered a solution to #{problem.issue.name}" +
              "  - #{problem_url(problem)}"
    else
      message = "I just offered a solution. Check it out:" +
                "  - #{problem_url(problem)}"
    end
    # current_user.post_to_twitter(message)
    Resque.enqueue(TwitterPoster, current_user.id, message)
  end
end
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
      redirect_to(problem_path(@problem), :notice => 'Problem was successfully created.')
      post_to_twitter(@problem, params) if params[:tweet].present?
    else
      render :action => "new"
    end
  end

  def edit
    @problem = current_user.problems.find(params[:id])
    @solution = @problem.original_solution
  end

  def update
    @problem = current_user.problems.find(params[:id])
    @solution = @problem.solutions.find(params[:id])
    if @problem.update_attributes(params[:problem])
      @solution.update_attributes(params[:problem][:solution])
      redirect_to problem_path(@problem), :alert => 'Problem updated successfully.'
    else
      render :edit, :alert => 'There was an error. Please try again.'
    end
  end

  def index
    @problems = Kaminari.paginate_array(Problem.by_votes).page(params[:page]).per(12)
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def destroy
    @problem = current_user.problems.find(params[:id])
    if @problem.destroy
      redirect_to problems_path, :notice => "Problem successfully deleted."
    else
      redirect_to problem_path(@problem), :notice => "There was a problem. Try again."
    end
  end

private

  def post_to_twitter(problem, params)
    raise params.inspect
    message = ["I just offered a solution"]
    problem.issue.present? ? message << " to #{problem.issue.name}. Check it out: " : message << ". Check it out: "
    message << problem_url(problem)
    message << " - cc @#{params[:tweet_pres]}" if params[:tweet_pres]
    message << " - cc @#{params[:tweet_pol]}" if params[:tweet_pol]
    Resque.enqueue(TwitterPoster, current_user.id, message.join(""))
  end
end

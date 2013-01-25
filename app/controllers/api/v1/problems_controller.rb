class Api::V1::ProblemsController < ApiController
  before_filter :authenticate

  def new
    @politician = Politician.find(params[:politician_id])
    @problem = @politician.problems.new
    @solution = @problem.solutions.new
  end

  def create
    @politician = Politician.find(params[:politician_id])
    @problem = @politician.problems.new(params[:problem])
    @solution = @problem.solutions.new(params[:problem][:solution])
    if @problem.save
      @problem.update_attributes(user_id: current_user.id)
      @solution.save!
      @solution.update_attributes(
        problem_id: @problem.id,
        user_id:    current_user.id
      )
      redirect_to api_v1_politician_problems_path(politician_id: @politician.id),
        notice: "Your problem has been submitted to #{@politician.short_title} #{@politician.last_name}."
      post_to_twitter(@problem, params) if params[:tweet].present?
    else
      render :action => "new"
    end
  end

  def index
    @politician = Politician.find(params[:politician_id])
    @problems = @politician.problems.reverse
  end

private

  def post_to_twitter(problem, params)
    message = ["I just offered a solution"]
    problem.issue.present? ? message << " to #{problem.issue.name}. Check it out: " : message << ". Check it out: "
    message << problem_url(problem)
    message << " - cc @#{params[:tweet_pres]}" if params[:tweet_pres]
    message << " - cc @#{params[:tweet_pol]}" if params[:tweet_pol]
    Resque.enqueue(TwitterPoster, current_user.id, message.join(""))
  end
end
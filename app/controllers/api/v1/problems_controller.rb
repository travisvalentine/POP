class Api::V1::ProblemsController < ApiController

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
    else
      render :action => "new"
    end
  end

  def index
    @politician = Politician.find(params[:politician_id])
    @problems = @politician.problems.reverse
  end
end
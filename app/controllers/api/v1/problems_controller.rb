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
      @solution.save!
      @solution.update_attributes(
        problem_id: @problem.id,
        user_id:    current_user.id
      )
      redirect_to(problem_path(@problem), :notice => 'Problem was successfully created.')
    else
      render :action => "new"
    end
  end

  def index
  end

end
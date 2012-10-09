class CommentsController < ApplicationController
  before_filter :find_problem_solution, :only => [:new]
  before_filter :authenticate, :only => :destroy

  def new
    @comment = Comment.new
  end

  def create
    @solution = Solution.find(params[:comment][:solution_id])
    @comment = @solution.comments.create(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(:back, :notice => 'Comment was successfully created.') }
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
    def find_problem_solution
      @problem = Problem.find(params[:id])
      @solution = @problem.solutions.find(params[:id])
    end
end
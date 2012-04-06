class SolutionsController < ApplicationController
  layout "application"
  before_filter :find_problem, :except => :destroy
  before_filter :authenticate, :only => :destroy

  def new
    @solution = @problem.solutions.new
  end

  def create
    @solution = @problem.solutions.new(params[:solution])
    respond_to do |format|
      if @problem.save
        @solution.save!
        @solution.update_attributes(problem_id: @problem.id, user_id: current_user.id)
        format.html { redirect_to(@problem.solutions.last, :notice => 'Problem was successfully created.') }
        format.xml  { render :xml => @problem.solutions.last, :status => :created, :location => @problem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @solution.errors, :status => :unprocessable_entity }
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
    redirect_to @problem, :notice => 'solution deleted'
  end

  private
    def find_problem
      @problem = Problem.find(params[:problem_id])
    end
end

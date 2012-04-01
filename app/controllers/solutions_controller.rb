class SolutionsController < ApplicationController
  layout "application"
  #before_filter :load_problem, :except => :destroy
  before_filter :authenticate, :only => :destroy

  def new
    solution = @problem.solutions.new(params[:solution])
  end

  def create
    @solution = @problem.solutions.build(params[:solution].merge(:user_id => current_user.id))
    respond_to do |format|
      if @solution.save
        format.html { redirect_to(@solution, :notice => 'Problem was successfully created.') }
        format.xml  { render :xml => @solution, :status => :created, :location => @solution }
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

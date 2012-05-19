class ProblemsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]
  layout "application"

  # GET
  def new
    @problem = Problem.new
  end

  # POST
  def create
    @problem = current_user.problems.new(params[:problem])
    @solution = @problem.solutions.new(params[:problem][:solution])
    respond_to do |format|
      if @problem.save
        @problem.issues << @problem.issue
        @solution.save!
        @solution.update_attributes(problem_id: @problem.id, user_id: current_user.id)
        format.html { redirect_to(@problem, :notice => 'Problem was successfully created.') }
        format.xml  { render :xml => @problem, :status => :created, :location => @problem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @problem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET
  def index
    @problems = Problem.all
  end

  # GET
  def show
    @problem = Problem.find(params[:id])
  end


  # GET
  def edit
    @problem = current_user.problems.find(params[:id])
  end

  # PUT /problems/1
  # PUT /problems/1.xml
  def update
    @problem = current_user.problems.find(params[:id])

    respond_to do |format|
      if @problem.update_attributes(params[:Problem])
        format.html { redirect_to(@problem, :notice => 'Problem was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @problem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE
  def destroy
    @problem = current_user.problems.find(params[:id])
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to(problems_url) }
      format.xml  { head :ok }
    end
  end

end
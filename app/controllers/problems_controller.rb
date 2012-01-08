class ProblemsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]
  layout "application"

  # GET /Problems
  # GET /Problems.xml
  def index
    @problems = Problem.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @problems }
    end
  end

  # GET /Problems/1
  # GET /Problems/1.xml
  def show
    @problem = Problem.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @problem }
    end
  end

  # GET /Problems/new
  # GET /Problems/new.xml
  def new
    @problem = Problem.new
    @problem.published_at = Time.now
    @solution = Solution.new
    @solution.published_at = Time.now
    respond_to do |format|
      format.html { }
      format.xml  { render :xml => @problem }
    end
  end

  # GET /Problems/1/edit
  def edit
    @problem = current_user.Problems.find(params[:id])
  end

  # POST /Problems
  # POST /Problems.xml
  def create
    @problem = current_user.Problems.new(params[:Problem])
    @problem.published_at = Time.now
    respond_to do |format|
      if @problem.save
        format.html { redirect_to(@problem, :notice => 'Problem was successfully created.') }
        format.xml  { render :xml => @problem, :status => :created, :location => @problem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @problem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /Problems/1
  # PUT /Problems/1.xml
  def update
    @problem = current_user.Problems.find(params[:id])

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

  # DELETE /Problems/1
  # DELETE /Problems/1.xml
  def destroy
    @problem = current_user.Problems.find(params[:id])
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to(Problems_url) }
      format.xml  { head :ok }
    end
  end

end
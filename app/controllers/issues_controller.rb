class IssuesController < ApplicationController
  layout "application"

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(params[:issue])
    if @issue.save
      redirect_to :back
    else
      render :new
    end
  end

  def show
    @issue = Issue.find(params[:id])
  end

  def index
    @issues = Issue.all
  end
end

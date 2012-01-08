class IssuesController < ApplicationController
  layout "application"

  def index
    @issues = Issue.all
  end
end

class ExistingProblemVotesController < ApplicationController
  before_filter :authenticate
  before_filter :set_return_session

  def create
    @problem = Problem.find(params[:id])
    if current_user
      current_user.unvote(@problem)
      redirect_to session[:return_to]
    else
      redirect_to(login_path, :alert => "Please log in to continue")
    end
  end
end
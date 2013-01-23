class ProblemDownvotesController < ApplicationController
  before_filter :set_return_session
  before_filter :authenticate

  def create
    @problem = Problem.find(params[:id])
    if current_user
      current_user.down_vote(@problem)
      redirect_to session[:return_to]
    else
      redirect_to(login_path, :alert => "Please log in to continue")
    end
  end
end

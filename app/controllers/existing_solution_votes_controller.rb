class ExistingSolutionVotesController < ApplicationController
  before_filter :set_return_session

  def create
    @solution = Solution.find(params[:id])
    if current_user
      current_user.unvote(@solution)
      redirect_to session[:return_to]
    else
      redirect_to(login_path, :notice => "Please log in to continue")
    end
  end
end
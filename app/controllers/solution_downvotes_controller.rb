class SolutionDownvotesController < ApplicationController
  before_filter :set_return_session

  def create
    @solution = Solution.find(params[:id])
    if current_user
      current_user.down_vote(@solution)
      redirect_to session[:return_to]
    else
      redirect_to(login_path, :alert => "Please log in to continue")
    end
  end
end

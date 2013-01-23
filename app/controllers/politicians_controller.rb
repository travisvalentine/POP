class PoliticiansController < ApplicationController
  before_filter :set_return_session, :only => [:show]

  def show
    @politician = Politician.find(params[:id])
  end

end
class PoliticiansController < ApplicationController

  def show
    @politician = Politician.find(params[:id])
  end

end
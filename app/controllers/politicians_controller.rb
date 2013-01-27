class PoliticiansController < ApplicationController
  before_filter :set_return_session, :only => [:show]

  def new
    @politician = Politician.new
  end

  def create
    @politician = Politician.new(params[:politician])
    if @politician.save
      redirect_to new_widget_path, notice: "Successfully created a new Politican. Awaiting approval."
    else
      render 'new', notice: "Something went wrong."
    end
  end

  def show
    @politician = Politician.find(params[:id])
  end

end
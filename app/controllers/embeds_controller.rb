class EmbedsController < ApplicationController

  def show
    @widget = Widget.find(params[:id])
    render layout: false
  end

end
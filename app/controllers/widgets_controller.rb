class WidgetsController < ApplicationController
  #before_filter :authenticate
  before_filter :find_widget, only: [:show]

  def new
    @widget = Widget.new
  end

  def create
    @widget = Widget.find_or_create_by_politician_id(params[:widget][:politician_id])
    if @widget || @widget.save
      redirect_to widget_path(@widget)
    else
      redirect_to session[:return_to]
    end
  end

  def show
    @widget = Widget.find(params[:id])
  end

  private

  def find_widget
    @widget = Widget.find_by_id(params[:id])
  end
end

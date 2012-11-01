class WidgetsController < ApplicationController
  before_filter :find_widget, only: [:show]

  def show
  end

  private

  def find_widget
    @widget = Widget.find_by_id(params[:id])
  end
end

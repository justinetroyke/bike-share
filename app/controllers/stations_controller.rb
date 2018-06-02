class StationsController < ApplicationController
  def show
    @station = Station.find_by(slug:params[:slug])
  end

  def index
    @stations = Station.all
  end

end

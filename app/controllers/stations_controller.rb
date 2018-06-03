class StationsController < ApplicationController
  def show
    @station = Station.find_by(slug:params[:slug])
    @start_trips = @station.start_trips
    @end_trips = @station.end_trips
  end

  def index
    @stations = Station.all
  end

end

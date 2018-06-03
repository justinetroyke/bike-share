class StationsController < ApplicationController
  def show
    @station = Station.find_by(slug:params[:slug])
    @start_trips = @station.start_trips
    @end_trips = @station.end_trips
    @most_frequent_destination = @station.most_frequent_destination
    @most_frequent_origination = @station.most_frequent_origination
    @busiest_date = @station.busiest_date
    @most_frequent_zip_code = @station.most_frequent_zip_code
    @favorite_bike = @station.favorite_bike
  end

  def index
    @stations = Station.all
  end

end

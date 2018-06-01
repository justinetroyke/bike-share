class TripsController < ApplicationController
  before_action :require_admin, only: [:destroy]
  def index
    @trips = Trip.order('start_date DESC').paginate(page: params[:page], per_page: 30)
  end
  
  def show
    @trip = Trip.find(params[:id])
    @start_station = Station.find(@trip.start_station_id)
    @end_station = Station.find(@trip.end_station_id)
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    redirect_to trips_path
  end
end

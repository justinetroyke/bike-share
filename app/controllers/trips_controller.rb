class TripsController < ApplicationController
  def index
    @trips = Trip.order('start_date DESC').paginate(page: params[:page], per_page: 30)
  end
end
class Trips::DashboardController < ApplicationController
  def index
    @trips = Trip.all
    @longest = Trip.longest
    @shortest = Trip.shortest
    @most_stated = Trip.station_most_started
    @most_ended = Trip.station_most_ended
    @most_used_bike = Trip.most_used_bike
  end
end

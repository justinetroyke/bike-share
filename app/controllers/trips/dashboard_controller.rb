class Trips::DashboardController < ApplicationController
  def index
    @trips = Trip.all
    @longest = Trip.longest
    @shortest = Trip.shortest
    @most_stated = Trip.station_most_started
    @most_ended = Trip.station_most_ended
    @most_used_bike = Trip.most_used_bike
    @least_used_bike = Trip.least_used_bike
    @subscriber = Trip.subscription_breakdown
    @highest_trip = Trip.date_with_most_trips
    @lowest_trip = Trip.date_with_least_trips
  end
end

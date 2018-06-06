class Trips::DashboardController < ApplicationController
  def index
    @trips = Trip.all
    @longest = Trip.longest
    @shortest = Trip.shortest
  end
end

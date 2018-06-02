class Stations::DashboardController < ApplicationController
  def index
    @total = Station.all.count
  end
end
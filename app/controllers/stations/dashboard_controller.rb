class Stations::DashboardController < ApplicationController
  def index
    @stations = Station.all
    @total = @stations.count
    @average_bikes_per_station = Station.average_bikes_per_station
    @most_bikes = Station.most_bikes
    @stations_with_most_bikes = Station.stations_with_most_bikes
    @least_bikes = Station.least_bikes
    @stations_with_least_bikes = Station.stations_with_least_bikes
    @newest_station = Station.where(installation_date: Station.minimum(:installation_date)).first
    @oldest_station = Station.where(installation_date: Station.maximum(:installation_date)).first
  end
end
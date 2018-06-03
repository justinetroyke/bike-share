class Stations::DashboardController < ApplicationController
  def index
    @stations = Station.all
    @total = @stations.count
    @average_bikes_per_station = @stations.average(:dock_count).round(2)
    @most_bikes = @stations.maximum(:dock_count)
    @stations_with_most_bikes = Station.where(dock_count: @most_bikes)
    @least_bikes = @stations.minimum(:dock_count)
    @stations_with_least_bikes = Station.where(dock_count: @least_bikes)
    @newest_station = Station.where(installation_date: Station.minimum(:installation_date)).first
    @oldest_station = Station.where(installation_date: Station.maximum(:installation_date)).first
  end
end
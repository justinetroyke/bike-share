require 'rails_helper'

RSpec.describe 'Stations Dashboard' do
  before :each do
    visit stations_dashboard_path
    @stations = []

    # I created stations a few times to salt the calculations for testing a bit

    @stations << Station.create!(name: "Station Least", dock_count: 1, city: "City 0", installation_date: DateTime.now)
    @stations << Station.create!(name: "Station Least Two", dock_count: 1, city: "City #{num}", installation_date: DateTime.now)

    18.times do |num|
      @stations << Station.create!(name: "Station #{num}", dock_count: 2, city: "City #{num}", installation_date: DateTime.now)
    end

    20.times do |num|
      @stations << Station.create!(name: "Station #{num}", dock_count: 3, city: "City #{num}", installation_date: DateTime.now)
    end

    @stations << Station.create!(name: "Station Most", dock_count: 4, city: "City 40", installation_date: DateTime.now)
    @stations << Station.create!(name: "Station Most Two", dock_count: 4, city: "City 40", installation_date: DateTime.now)
  end
  describe 'Any user type visits the stations dashboard page' do
    it 'they should see the total count of stations' do
      expect(page).to have_content("Total Stations: #{@stations.length}")
    end

    it 'should show the average bikes per station based on dock count' do
      expect(page).to have_content("Average Bikes per Station: 2.5")
    end

    it 'should show the most bikes available at a station and that stations name' do
      expect(page).to have_content("Most Bikes: 4 at station: Station Least")
    end
  end
end
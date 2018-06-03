require 'rails_helper'

RSpec.describe 'Stations Dashboard' do
  before :each do
    @stations = []
    
    # I created stations a few times to salt the calculations for testing a bit
    
    @stations << Station.create!(name: "Station Least", dock_count: 1, city: "City 0", installation_date: Date.parse('2014-01-01'))
    @stations << Station.create!(name: "Station Least Two", dock_count: 1, city: "City 0", installation_date: Date.parse('2015-01-01'))
    
    18.times do |num|
      @stations << Station.create!(name: "Station #{num}", dock_count: 2, city: "City #{num}", installation_date: Date.parse('2015-01-01'))
    end
    
    20.times do |num|
      @stations << Station.create!(name: "Station #{num}", dock_count: 3, city: "City #{num}", installation_date: Date.parse('2015-01-01'))
    end
    
    @stations << Station.create!(name: "Station Most", dock_count: 4, city: "City 40", installation_date: Date.parse('2015-01-01'))
    @stations << Station.create!(name: "Station Most Two", dock_count: 4, city: "City 40", installation_date: Date.parse('2016-01-01'))
    
    visit stations_dashboard_path
  end
  describe 'Any user type visits the stations dashboard page' do
    it 'they should see the total count of stations' do
      expect(page).to have_content("Total Stations: #{@stations.length}")
    end

    it 'should show the average bikes per station based on dock count' do
      expect(page).to have_content("Average Bikes per Station: 2.5")
    end

    it 'should show the most bikes available at a station or stations and that station(s)\' name(s)' do
      expect(page).to have_content("Most Bikes: 4 at station(s): Station Most Station Most Two")
    end

    it 'should show the least bikes available at a station or stations and that station(s)\' name(s)' do
      expect(page).to have_content("Least Bikes: 1 at station(s): Station Least Station Least Two")
    end

    it 'should show the most recently installed station' do
      save_and_open_page
      expect(page).to have_content("Most Recently Installed Station: #{@stations.first.name}")
    end

    it 'should show the oldest station' do
      expect(page).to have_content("Oldest Station: #{@stations.last.name}")
    end
  end
end
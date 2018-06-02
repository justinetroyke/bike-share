require 'rails_helper'

RSpec.describe 'Stations Dashboard' do
  before :each do
    visit stations_dashboard_path
    @stations = []
    40.times do |num|
      @stations << Station.create!(name: "Station #{num}", dock_count: 2, city: "City #{num}", installation_date: DateTime.now)
    end
  end
  describe 'Any user type visits the stations dashboard page' do
    it 'they should see the total count of stations' do
      expect(page).to have_content("Total Stations: #{@stations.length}")
    end
  end
end
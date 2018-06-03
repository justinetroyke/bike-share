require 'rails_helper'

RSpec.describe Station do
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
  end

  after :all do
    @stations = nil
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:dock_count) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:installation_date) }
  end

  describe 'Relationships' do
    it { is_expected.to have_many(:start_trips) }
    it { is_expected.to have_many(:end_trips) }
  end

  describe 'Instance Methods' do
    describe '#generate_slug' do
      it 'should create a slug out of the station name' do
        station1 = Station.new(name: 'Station Name',
                               dock_count: 12,
                               city: 'Denver',
                               installation_date: '2015-01-02',
                               slug: nil)

        station1.generate_slug

        expect(station1.slug).to eq(station1.name.parameterize)
      end
    end
  end

  describe 'Class Methods' do
    describe '#average_bikes_per_station' do
      it 'should return the average number of bikes based on all stations\' dock counts, rounded' do
        expect(Station.average_bikes_per_station).to eq((@stations.sum { |station| station.dock_count }.to_f / @stations.length).round(2))
      end
    end

    describe '#most_bike' do
      it 'should return the number of the station(s) with the most bikes available' do
        expect(Station.most_bikes).to eq(4)
      end
    end

    describe '#station_with_most_bikes' do
      it 'should return the stations with the dock_count the same as the maximum dock count across all stations' do
        binding.pry
        expect(Station.stations_with_most_bikes).to eq([@stations[-2], @stations[-1]])
      end
    end

    describe '#least_bikes' do
      it 'should return the number of bikes at the station(s) with the least amount of bikes' do
        expect(Station.least_bikes).to eq(1)
      end
    end

    describe '#station_with_least_bikes' do
      it 'should return the stations with the dock_count the same as the minimum dock count across all stations' do
        expect(Station.stations_with_least_bikes).to eq([@stations[0], @stations[1]])
      end
    end
  end
end

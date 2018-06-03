require 'rails_helper'

RSpec.describe Station do
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

  describe 'Insatance Methods' do
    before(:all) do
      @station = Station.create!(name: 'Union Station',
                                dock_count: 12,
                                city: 'Denver',
                                installation_date: DateTime.now)
      @station2 = Station.create!(name: '19th street',
                                  dock_count: 12,
                                  city: 'Denver',
                                  installation_date: DateTime.now)

      10.times do |num|
        Trip.create!(duration: 5,
                    start_date:Time.now - 1.hour,
                    end_date:Time.now,
                    bike_id: num,
                    zip_code: rand(1000),
                    start_station_id:@station.id,
                    end_station_id:@station2.id,
                    subscription_type:2)
      end
    end
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
    describe 'most_frequent_destination' do
      it 'should return the most visited end station from this station' do
        require'pry';binding.pry
        expect(@station1.most_frequent_destination).to eq(@station2)
      end
    end
    describe 'most_frequent_origination' do
      it 'should return station which most trips to this station originate from' do
        expect(@station1.most_frequent_origination).to eq(@station2)
      end
    end
    describe 'busiest_date' do
      it 'should return busiest date of operation' do
        expect(@station1.busiest_date).to eq(Time.now)
      end
    end
    describe 'most_frequent_zip_code' do
      it 'should reuturn the most common zip code of users of this station' do
      end
    end
    describe 'favorite_bike' do
      it 'should reuturn id of the favorite bike of this station' do
      end
    end
  end
end

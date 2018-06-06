require 'rails_helper'

RSpec.describe Trip do
  before :each do
    @station = Station.create!(name:'name',
                              dock_count:5,
                              city:'denver',
                              installation_date:Time.now)
    @trips = []
    20.times do |num|
      @trips << Trip.create!(duration: num,
                  start_date: Time.now,
                  bike_id: num+1,
                  subscription_type: 'subscriber',
                  zip_code: 23456,
                  start_station_id: @station.id,
                  end_station_id: @station.id,
                  end_date: Time.now)
    end

    20.times do |num|
      @trips << Trip.create!(duration: num,
                  start_date: Time.now,
                  bike_id: num+1,
                  subscription_type: 'customer',
                  zip_code: 23456,
                  start_station_id: @station.id,
                  end_station_id: @station.id,
                  end_date: Time.now)
    end
  end
  describe 'Validations' do
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:start_station_id) }
    it { should validate_presence_of(:end_station_id) }
    it { should validate_presence_of(:bike_id) }
    it { should validate_presence_of(:subscription_type) }
    it { should validate_inclusion_of(:subscription_type).in_array(%w[subscriber customer])}
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:start_station) }
    it { is_expected.to belong_to(:end_station) }
  end

  describe 'Class Methods' do
    describe 'average_trip_duration' do
      it 'should return the average duration of all trips' do
        expect(Trip.average_duration).to eq(9.5)
      end
    end
    describe 'longest_trip' do
      it 'should return the longest trip' do
        trip = Trip.create(duration: 2313,
                    start_date: Time.now,
                    bike_id: 12,
                    subscription_type: 'subscriber',
                    zip_code: 23456,
                    start_station_id: @station.id,
                    end_station_id: @station.id,
                    end_date: Time.now,
                    )

        expect(Trip.longest).to eq(trip)
      end
    end
    describe 'shortest_trip' do
      it 'should return the shortest trip' do
        trip = Trip.shortest

        expect(Trip.shortest).to eq(trip)
      end
    end
    describe 'station_most_started' do
      it 'should return the station with most trips started' do
        @station2 = Station.create!(name:'name',
                        dock_count:5,
                        city:'denver',
                        installation_date:Time.now)
        Trip.create(duration: 2313,
                    start_date: Time.now,
                    bike_id: 12,
                    subscription_type: 0,
                    zip_code: 23456,
                    start_station_id: @station2.id,
                    end_station_id: @station2.id,
                    end_date: Time.now,
                    )

        expect(Trip.station_most_started).to eq(@station)
      end
    end
    describe 'station_most_ended' do
      it 'should return the station with most trips started' do
        @station2 = Station.create!(name:'name',
                        dock_count:5,
                        city:'denver',
                        installation_date:Time.now)
        Trip.create(duration: 2313,
                    start_date: Time.now,
                    bike_id: 12,
                    subscription_type: 0,
                    zip_code: 23456,
                    start_station_id: @station2.id,
                    end_station_id: @station2.id,
                    end_date: Time.now,
                    )

        expect(Trip.station_most_ended).to eq(@station)
      end
    end

    describe 'date_with_least_trips' do
      it 'should return the date with the least trips' do
        trip = Trip.create!(duration: 12,
          start_date: DateTime.parse('02/10/1999'),
          end_date: DateTime.parse('02/10/1999'),
          bike_id: 42,
          subscription_type: 'customer',
          zip_code: 80202,
          start_station_id: @station.id,
          end_station_id: @station.id)
        expect(Trip.date_with_least_trips).to eq(trip.end_date)
      end
    end

    describe 'date_with_most_trips' do
      it 'should return the date with the most trips' do
        trip = Trip.create!(duration: 12,
          start_date: DateTime.parse('02/10/1999'),
          end_date: DateTime.parse('02/10/1999'),
          bike_id: 42,
          subscription_type: 'customer',
          zip_code: 80202,
          start_station_id: @station.id,
          end_station_id: @station.id)
        expect(Trip.date_with_most_trips).to eq(@trips[0].end_date)
      end
    end

    describe 'subscription_breakdown' do
      it 'should return a hash with the subscription_type as key and the count and percentage inside of that' do
        expect(Trip.subscription_breakdown).to eq({ 'subscriber' => { 'count' => 20, 'percentage' => 50 }, 
                                                    'customer' => { 'count' => 20, 'percentage' => 50 } })
      end
    end

    describe 'least_used_bike' do
      it 'should return the least ridden bike id and its total rides' do
        trip = Trip.create!(duration: 12,
          start_date: DateTime.parse('02/10/1999'),
          end_date: DateTime.parse('02/10/1999'),
          bike_id: 102,
          subscription_type: 'customer',
          zip_code: 80202,
          start_station_id: @station.id,
          end_station_id: @station.id)

          expect(Trip.least_used_bike).to eq({ bike: 102, total: 1 })
      end
    end

    describe 'most_used_bike' do
      it 'should return the most ridden bike id and its total rides' do
        trip = Trip.create!(duration: 12,
          start_date: DateTime.parse('02/10/1999'),
          end_date: DateTime.parse('02/10/1999'),
          bike_id: 1,
          subscription_type: 'customer',
          zip_code: 80202,
          start_station_id: @station.id,
          end_station_id: @station.id)

          expect(Trip.most_used_bike).to eq({ bike: 1, total: 3 })
      end
    end
  end
end

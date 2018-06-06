require 'rails_helper'

RSpec.describe Trip do
  before :each do
    @station = Station.create!(name:'name',
                              dock_count:5,
                              city:'denver',
                              installation_date:Time.now)
      @trips = 40.times do |num|
        Trip.create(duration: num,
                    start_date: Time.now,
                    bike_id: num+rand(10),
                    subscription_type: 0,
                    zip_code: 23456,
                    start_station_id: @station.id,
                    end_station_id: @station.id,
                    end_date: Time.now,
                    )
    end
  end
  describe 'Validations' do
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:start_station_id) }
    it { should validate_presence_of(:end_station_id) }
    it { should validate_presence_of(:bike_id) }
    it { should validate_presence_of(:subscription_type) }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:start_station) }
    it { is_expected.to belong_to(:end_station) }
  end
  describe 'average_trip_duration' do
    it 'should return the average duration of all trips' do
      expect(@trips.average_duration).to eq(19.5)
    end
  end
end

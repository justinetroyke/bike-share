require 'rails_helper'

RSpec.describe 'Trips Dashboard' do
  before :each do
    @station = Station.create!(name:'name',
                              dock_count:5,
                              city:'denver',
                              installation_date:Time.now)
    @station2 = Station.create!(name:'name',
                                dock_count:5,
                                city:'denver',
                                installation_date:Time.now)
      40.times do |num|
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
      20.times do |num|
       Trip.create(duration: 2340,
                   start_date: Time.now,
                   bike_id: num+rand(10),
                   subscription_type: 0,
                   zip_code: 23456,
                   start_station_id: @station2.id,
                   end_station_id: @station2.id,
                   end_date: Time.now,
                 )
    end
    visit trips_dashboard_path
  end
  describe 'Any user type visits the trips dashboard page' do
    it 'they should see the average duration of a ride' do
      expect(page).to have_content("Average Trip Duration: #{Trip.all.average('duration')}")
    end
    it 'they should see the longest ride' do
      trip = Trip.longest

      expect(page).to have_content("Longest Trip:")
      expect(page).to have_link(trip.id)
      expect(page).to have_content("Duration: #{trip.duration}")
    end
    it 'they should see the shortest ride' do
      trip = Trip.shortest

      expect(page).to have_content("Shortest Trip:")
      expect(page).to have_link(trip.id)
      expect(page).to have_content("Duration: #{trip.duration}")
    end
    it 'they should see the station with most rides started at' do
      trip = Trip.shortest

      expect(page).to have_content("Shortest Trip:")
      expect(page).to have_link(trip.id)
      expect(page).to have_content("Duration: #{trip.duration}")
    end
    it 'they should see the station with most rides started at' do
      station = Trip.station_most_started

      expect(page).to have_content("Station Most Trips Started At:")
      expect(page).to have_link(station.name)
    end
    it 'they should see the station with most rides ending at' do
      station = Trip.station_most_ended

      expect(page).to have_content("Station Most Trips Ended At:")
      expect(page).to have_link(station2.name)
    end
  end
end

# I see the Station with the most rides as an ending place,
# I see Month by Month breakdown of number of rides
# with subtotals for each year,
# I see the Most ridden bike with total number
# of rides for that bike,
# I see the Least ridden bike with total number of
# rides for that bike,
# I see the User subscription type breakout with both
# count and percentage,
# I see the Single date with the highest number of
# trips with a count of those trips,
# I see the Single date with the lowest number of
# trips with a count of those trips.

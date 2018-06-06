require 'rails_helper'

RSpec.describe 'Trips Dashboard' do
  before :each do
    @station = Station.create!(name:'name',
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
      visit trips_dashboard_path
    end
  end
  describe 'Any user type visits the trips dashboard page' do
    it 'they should see the average duration of a ride' do
      expect(page).to have_content("Average Trip Duration: #{Trip.all.average('duration')}")
    end
  end
end

# As a registered user,
# When I visit /trips-dashboard,
# I see the Average duration of a ride,
# I see the Longest ride,
# I see the Shortest ride,
# I see the Station with the most rides as a starting place,
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

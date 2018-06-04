require 'rails_helper'

describe 'When you click on a specific trip' do
  context 'as a visitor' do
    it 'shows all attributes of a trip' do
      station = Station.create!(
        name: 'Union Station',
        dock_count: 12,
        city: 'Denver',
        installation_date: Time.parse('2010-05-05 00:00:00')
      )
      trip = Trip.create!(
        duration: 1315,
        start_date: Time.parse('2018-05-05 13:10:00'),
        end_date: Time.parse('2018-05-05 14:02:00'),
        start_station_id: station.id,
        end_station_id: station.id,
        bike_id: 64,
        subscription_type: 'subscriber',
        zip_code: 80202
      )

      visit trip_path(trip)

      expect(page).to have_content("Duration: #{trip.duration}")
      expect(page).to have_content("Start Date: #{trip.start_date.strftime("%Y/%m %A, %I:%M %p")}")
      expect(page).to have_content("End Date: #{trip.end_date.strftime("%Y/%m %A, %I:%M %p")}")
      expect(page).to have_content("Start Station: #{station.name}, ID: #{trip.start_station_id}")
      expect(page).to have_content("End Station: #{station.name}, ID: #{trip.end_station_id}")
      expect(page).to have_content("Bike ID: #{trip.bike_id}")
      expect(page).to have_content("Subscription: #{trip.subscription_type}")
      expect(page).to have_content("Zip Code: #{trip.zip_code}")
    end
  end
end

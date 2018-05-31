require 'rails_helper'

RSpec.describe 'Trip Show Page (Admin)' do
  before :each do
    @admin = User.create!(username: 'admin', password: 'adminlogin', address: '123 admin street', first_name: 'Admin', last_name: 'User', role: 1)
    @station = Station.create!(
      name: 'Union Station',
      dock_count: 12,
      city: 'Denver',
      installation_date: Time.parse('2010-05-05 00:00:00')
    )

    @trip = Trip.create!(
      duration: 1315,
      start_date: Time.parse('2018-05-05 13:10:00'),
      end_date: Time.parse('2018-05-05 14:02:00'),
      start_station_id: station.id,
      end_station_id: station.id,
      bike_id: 64,
      subscription_type: 'subscriber',
      zip_code: 80202
    )
    allow_anh_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit trip_path(trip)
  end
  describe 'An admin user visits the show page for a specific trip' do
    it 'they should see all of the trips attributes' do
      expect(page).to have_content("Duration: #{@trip.duration}")
      expect(page).to have_content("Start Date: #{@trip.start_date}")
      expect(page).to have_content("End Date: #{@trip.end_date}")
      expect(page).to have_content("Start Station: #{@trip.start_station_id}")
      expect(page).to have_content("End Station: #{@trip.end_station_id}")
      expect(page).to have_content("Bike ID: #{@trip.bike_id}")
      expect(page).to have_content("Subscription: #{@trip.subscription_type}")
      expect(page).to have_content("Zip Code: #{@trip.zip_code}")
    end

    it 'they should also see a link to edit the trip' do
      expect(page).to have_link('Edit')
      click_link 'Edit'
      expect(page).to have_current_path(edit_admin_trip(@trip))
    end

    it 'they should also see a link to delete the trip' do
      expect(page).to have_link('Delete')
      click_link 'Delete'
      expect(page).to have_current_path(trips_path)
      expect(page).to_not have_content("Duration: #{@trip.duration}")
      expect(page).to_not have_content("Start Date: #{@trip.start_date}")
      expect(page).to_not have_content("End Date: #{@trip.end_date}")
      expect(page).to_not have_content("Start Station: #{@trip.start_station_id}")
      expect(page).to_not have_content("End Station: #{@trip.end_station_id}")
      expect(page).to_not have_content("Bike ID: #{@trip.bike_id}")
      expect(page).to_not have_content("Subscription: #{@trip.subscription_type}")
      expect(page).to_not have_content("Zip Code: #{@trip.zip_code}")
    end
  end
end

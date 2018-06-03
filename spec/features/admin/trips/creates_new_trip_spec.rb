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
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  describe 'An admin user visits the new trip page and fills in form' do
    it 'it clicks create trip and is directed to trip/s show page' do
      visit new_admin_trip_path(@station)
# save_and_open_page

      fill_in 'trip[duration]', with: 1201
      fill_in 'trip[start_date]', with: Time.parse('2018-05-05 13:10:00')
      fill_in 'trip[end_date]', with: Time.parse('2018-05-05 14:02:00')
      fill_in 'trip[start_station_id]', with: @station.id
      fill_in 'trip[end_station_id]', with: @station.id
      fill_in 'trip[zip_code]', with: 80202
      click_button 'Create Trip'

      expect(current_path).to eq(admin_trip_path(Trip.last))
    end
  end
end

# As an admin user,
# When I visit admin trip new,
# I fill in a form with all trip attributes,
# When I click "Create Trip",
# I am directed to that trip's show page.
# I also see a flash message that I have created that trip.
# ** Zip Code is a user-provided field, and may not be present
# on all records. Otherwise, as with Stations, all attributes of a Trip need to be present to ensure data integrity **

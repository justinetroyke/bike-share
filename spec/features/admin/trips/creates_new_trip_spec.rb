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

    @station2 = Station.create!(
      name: 'Civic Center',
      dock_count: 12,
      city: 'Denver',
      installation_date: Time.parse('2010-05-05 00:00:00')
    )
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  describe 'An admin user visits the new trip page and fills in form' do
    it 'it clicks create trip through trips index and is directed to trip/s show page' do
      sub_time = 0
      duration = 1201
      bike_id = 22
      start_date = Time.parse('2018-05-05 13:10:00')
      end_date = Time.parse('2018-05-05 14:02:00')
      zip = 80202

      visit trips_path

      click_link 'Create New Trip'

      expect(current_path).to eq(new_admin_trip_path)

      select 'Subscriber', from: 'Subscription Type'
      fill_in 'trip[duration]', with: duration
      fill_in 'trip[bike_id]', with: bike_id
      fill_in 'trip[start_date]', with: start_date
      fill_in 'trip[end_date]', with: end_date
      select @station2.name, from: 'Start Station'
      select @station.name, from: 'End Station'
      fill_in 'trip[zip_code]', with: zip
      click_button 'Create Trip'

      expect(page).to have_content(sub_time)
      expect(page).to have_content(duration)
      expect(page).to have_content('2018/05 Saturday, 07:10 PM')
      expect(page).to have_content('2018/05 Saturday, 08:02 PM')
      expect(page).to have_content(bike_id)
      expect(page).to have_content(@station.id)
      expect(page).to have_content(zip)
      expect(current_path).to eq(trip_path(Trip.last))
      expect(page).to have_content("Trip Created")
    end

    it 'it clicks create trip through admin dashboard and is directed to trip/s show page' do
      visit admin_dashboard_path

      click_link 'Create New Trip'

      expect(current_path).to eq(new_admin_trip_path)
    end
  end
end

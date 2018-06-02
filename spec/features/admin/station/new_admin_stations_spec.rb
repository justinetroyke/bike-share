require 'rails_helper'

RSpec.feature "NewAdminStations", type: :feature do
  describe 'An admin' do
    describe 'visiting the new admin station page' do
      it 'should make a new station after filling in the form' do
        admin = User.create!(username:'admin',
                             password:'password',
                             first_name:'big',
                             last_name:'boss',
                             role:1,
                             address:'1234 asdfg')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit new_admin_station_path

        name = "station name is something"
        dock_count = 10
        city = 'Denver'
        installation_date = Time.now
        
        fill_in 'station[name]', with: name
        fill_in 'station[dock_count]', with: dock_count
        fill_in 'station[city]', with: city
        fill_in 'station[installation_date]', with: installation_date
        click_on('Create Station')

        station = Station.find_by(name:name)
        expect(current_path).to eq(station_path(station))
        expect(page).to have_content("#{station.name} Station Created")
      end
    end
  end
end

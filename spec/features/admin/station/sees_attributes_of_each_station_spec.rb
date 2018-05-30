require 'rails_helper'

RSpec.feature 'Admin Visits Station Index', type: :feature do
  describe 'An admin user' do
    context 'visiting station index path' do
      before(:all) do
        @stations = []
        @stations << station1 = Station.create!(name:'first one',
          dock_count:5,
          city:'denver',
          installation_date: DateTime.now)

        @stations << station2 = Station.create!(name:'another name',
                  dock_count:5,
                  city:'denver',
                  installation_date: DateTime.now)

        @admin = User.create!(username:'username',
                              password:'password',
                              first_name:'john',
                              last_name:'smith',
                              address:'1234 address',
                              role:1)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      end
    end

    it 'shows all attributes of station' do
      visit stations_path

      @stations.each do |station|
        expect(page).to have_content(station.name)
        expect(page).to have_content(station.dock_count)
        expect(page).to have_content(station.city)
        expect(page).to have_content(station.installation_date.strftime('%d %B %Y'))
      end
    end

    it 'shows edit and delete on all stations' do
      visit stations_path

      @stations.each do |station|
        within("#station_#{station.id}") do
          expect(page).to have_link('Delete')
          expect(page).to have_link('Edit')
        end
      end
    end
  end
end

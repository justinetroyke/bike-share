require 'rails_helper'

RSpec.feature 'Admin Visits Station Index', type: :feature do
  describe 'An admin user' do
    context 'visiting station index path' do
      before(:all) do
        @stationss = []
        @stationss << station1 = Station.create!(name:'first one',
          dock_count:5,
          city:'denver',
          installation_date: DateTime.now)

        @stationss << station2 = Station.create!(name:'another name',
                  dock_count:5,
                  city:'denver',
                  installation_date: DateTime.now)

        @admin = User.create!(username:'John',
                              password:'smith',
                              first_name:'john',
                              last_name:'smith',
                              address:'1234 address',
                              role:1)

      end

      after :all do
        @stationss = nil
      end
      it 'shows all attributes of station' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

        visit stations_path

        @stationss.each do |station|
          expect(page).to have_content(station.name)
          expect(page).to have_content(station.dock_count)
          expect(page).to have_content(station.city)
          expect(page).to have_content(station.installation_date.strftime('%d %B %Y'))
        end
      end

      it 'shows edit and delete on all stations' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

        visit stations_path

        @stationss.each do |station|
          within("#station_#{station.id}") do
            expect(page).to have_button('Delete')
            expect(page).to have_button('Edit')
          end
        end
      end
    end
  end
end

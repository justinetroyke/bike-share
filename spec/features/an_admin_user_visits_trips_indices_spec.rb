require 'rails_helper'

RSpec.feature "An Admin User Visits Trips Index", type: :feature do
  describe 'an admin user' do
    context 'visiting the trips index' do

      before(:all) do
        @station1 = Station.create!(name:'name',
          dock_count:5,
          city:'denver',
          installation_date: DateTime.now)

        @station2 = Station.create!(name:'name',
                  dock_count:5,
                  city:'denver',
                  installation_date: DateTime.now)

        @trip1 = Trip.create!(duration: 5,
            start_date: DateTime.now,
            bike_id: 10,
            subscription_type: 0,
            zip_code: 23456,
            start_station_id: @station1.id,
            end_station_id: @station2.id,
            end_date: DateTime.now)
      end

      it 'should show all info visible to a user' do
        visit trips_path

        within('li:nth-child(1)') do
          expect(page).to have_content(@trip.duration)
          expect(page).to have_content(@trip.start_date)
          expect(page).to have_content(@trip.end_date)
          expect(page).to have_content(@station2.name)
          expect(page).to have_content(@station1.name)
        end
      end

      context 'edit button' do
        it 'should have an edit button next to each trip' do
          visit trips_path

          within('li:nth-child(1)') do
            expect(page).to have_button('Edit')
          end
        end
      end

      context 'delete button' do
        it 'should have a delete button next to each trip' do
          visit trips_path

          within('li:nth-child(1)') do
            expect(page).to have_button('Delete')
          end
        end
      end
    end
  end
end

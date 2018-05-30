require 'rails_helper'

RSpec.feature "An Admin User Visits Trips Index", type: :feature do
  describe 'an admin user' do
    context 'visiting the trips index' do

      before(:each) do
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
            zip_code: 94053,
            start_station_id: @station1.id,
            end_station_id: @station2.id,
            end_date: DateTime.now)
      end

      it 'should show all info visible to a user' do
        admin = User.create!(username:'username',
          password:'password',
          first_name:'john',
          last_name:'smith',
          address:'1234 address',
          role:1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit trips_path
        within('li:nth-child(1)') do
          expect(page).to have_content(@trip1.duration)
          expect(page).to have_content(@trip1.start_date)
          expect(page).to have_content(@trip1.end_date)
          expect(page).to have_content(@station2.name)
          expect(page).to have_content(@station1.name)
        end
      end

      context 'edit button' do
        it 'should have an edit button next to each trip' do
          admin = User.create!(username:'username',
                               password:'password',
                               first_name:'john',
                               last_name:'smith',
                               address:'1234 address',
                               role:1)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

          visit trips_path

          within('li:nth-child(1)') do
            expect(page).to have_button('Edit')
          end
        end
      end

      context 'delete button' do
        it 'should have a delete button next to each trip' do
          admin = User.create!(username:'username',
            password:'password',
            first_name:'john',
            last_name:'smith',
            address:'1234 address',
            role:1)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

          visit trips_path

          within('li:nth-child(1)') do
            expect(page).to have_button('Delete')
          end
        end
        it 'should delete the related trip' do
          admin = User.create!(username:'username',
            password:'password',
            first_name:'john',
            last_name:'smith',
            address:'1234 address',
            role:1)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

          visit trips_path

          within('li:nth-child(1)') do
            click_on('Delete')
          end

          expect(page).to_not have_content(@trip1.zip_code)
        end
      end
    end
  end
end

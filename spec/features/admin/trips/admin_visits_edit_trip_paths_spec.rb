require 'rails_helper'

RSpec.feature "Admin Visits Edit Trip Path", type: :feature do
  describe 'An admin user' do
    context 'visiting edit admin path' do
      before(:all) do
        @station1 = Station.create!(name:'first one',
          dock_count:5,
          city:'denver',
          installation_date: DateTime.now)

        @station2 = Station.create!(name:'another name',
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

      it 'should have a form for editing a trip' do
        admin = User.create!(username:'username',
                              password:'password',
                              first_name:'john',
                              last_name:'smith',
                              address:'1234 address',
                              role:1)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit edit_admin_trip_path(@trip1)

        expect(page).to have_field('trip[bike_id]')
        expect(page).to have_field('trip[subscription_type]')
        expect(page).to have_field('trip[zip_code]')
        expect(page).to have_field('trip[bike_id]')
        expect(page).to have_field('trip[start_station_id]')
        expect(page).to have_field('trip[end_station_id]')
        expect(page).to have_field('trip[start_date]')
        expect(page).to have_field('trip[end_date]')

      end
      it 'should redirect to trip show page after submitting, and show the updated info, as well as a flash message' do
        admin = User.create!(username:'username',
          password:'password',
          first_name:'john',
          last_name:'smith',
          address:'1234 address',
          role:1)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit edit_admin_trip_path(@trip1)
        old_zip = @trip1.zip_code
        new_zip = 54321
        fill_in 'trip[zip_code]', with: new_zip
        fill_in 'trip[start_station_id]', with: @station2.id
        click_on 'Update Trip'

        expect(current_path).to eq(trip_path(@trip1))
        expect(page).to_not have_content(@station1.name)
        expect(page).to_not have_content(old_zip)
        expect(page).to have_content(@station2.name)
        expect(page).to have_content(new_zip)
      end
    end
  end
end

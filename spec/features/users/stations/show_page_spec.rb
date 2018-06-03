require 'rails_helper'

RSpec.feature "Station Show page", type: :feature do
  describe 'A User' do 
    describe 'visits the station show page' do
      before(:all) do
        @user = User.create!(username:'someone',
                            first_name:'whoever',
                            last_name:'someone else',
                            role:0,
                            password: 'password',
                            address:'most places eventually')
        @station = Station.create!(name: 'Union Station', 
                                   dock_count: 12, 
                                   city: 'Denver', 
                                   installation_date: DateTime.now)
        @station2 = Station.create!(name: '19th street', 
                                    dock_count: 12, 
                                    city: 'Denver', 
                                    installation_date: DateTime.now)

        10.times do |num|
          Trip.create!(duration: 5,
                       start_date:Time.now - 1.hour,
                       end_date:Time.now,
                       bike_id: num,
                       zip_code: rand(1000),
                       start_station_id:@station.id,
                       end_station_id:@station2.id,
                       subscription_type:2)
        end
        7.times do |num|
          Trip.create!(duration: 5,
                       start_date:Time.now- 1.hour,
                       end_date:Time.now,
                       bike_id: num,
                       zip_code: rand(1000),
                       start_station_id:@station2.id,
                       end_station_id:@station.id,
                       subscription_type:2)
        end
      end
      it 'should show the number of rides started at that station' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit station_path(@station.slug)
        expect(page).to have_content('Trips started at this station: 10')
      end

      it 'should show the Number of rides ended at this station' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit station_path(@station.slug)
        expect(page).to have_content('Trips ended at this station: 7')
      end

      it 'should show the Most frequent destination station (for rides that began at this station)' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit station_path(@station.slug)
        expect(page).to have_content("Most frequent destination, from this station: #{@station2.name}")
      end

      it 'should the Most frequent origination station (for rides that ended at this station' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit station_path(@station.slug)
        expect(page).to have_content("Most frequent origination point, for this station: #{@station2.name}")
      end

      it 'should show the Date with the highest number of trips started at this station' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit station_path(@station.slug)
        expect(page).to have_content("Busiest date for #{@station.name}: #{Time.now}")
      end
      it 'should show the Most frequent zip code for users starting trips at this station' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit station_path(@station.slug)
        expect(page).to have_content("Most frequent zipcode of users using this station: #{@station.most_frequent_zip}")
      end
      it 'should show the Bike ID most frequently starting a trip at this station.' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit station_path(@station.slug)
        expect(page).to have_content("Most used bike at #{@station.name}: #{@station.most_frequent_bike}")
      end
    end
  end
end
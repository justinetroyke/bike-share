require 'rails_helper'

RSpec.describe 'Trips Dashboard' do
  before :each do
    user = User.create!(username: 'user', password: 'password', address: '123 Not A Street', first_name: 'Registered', last_name: 'User', role: 0)
    @station = Station.create!(name:'name',
                              dock_count:5,
                              city:'denver',
                              installation_date:Time.now)
    @trips = []
    20.times do |num|
      @trips << Trip.create!(duration: num+2,
                  start_date: Time.now,
                  bike_id: num+1,
                  subscription_type: 'subscriber',
                  zip_code: 23456,
                  start_station_id: @station.id,
                  end_station_id: @station.id,
                  end_date: Time.now)
    end

    20.times do |num|
      @trips << Trip.create!(duration: num+2,
                  start_date: Time.now,
                  bike_id: num+1,
                  subscription_type: 'customer',
                  zip_code: 23456,
                  start_station_id: @station.id,
                  end_station_id: @station.id,
                  end_date: Time.now)
    end

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  describe 'A registered user visits the trips dashboard page' do
    it 'they should see the average duration of all rides' do
      visit trips_dashboard_path

      expect(page).to have_content("Average Trip Duration: 11.5")
    end

    it 'they should see the longest ride' do
      trip = Trip.create(duration: 2313,
        start_date: Time.now,
        bike_id: 12,
        subscription_type: 'subscriber',
        zip_code: 23456,
        start_station_id: @station.id,
        end_station_id: @station.id,
        end_date: Time.now)

      visit trips_dashboard_path

      within('#longest-ride') do
        expect(page).to have_content("Longest Ride:")
        expect(page).to have_content("Trip: #{trip.id}")
        expect(page).to have_content(" Duration: #{trip.duration}")
      end
    end

    it 'they should see the shortest ride' do
      trip = Trip.create(duration: 1,
        start_date: Time.now,
        bike_id: 12,
        subscription_type: 'subscriber',
        zip_code: 23456,
        start_station_id: @station.id,
        end_station_id: @station.id,
        end_date: Time.now)

        visit trips_dashboard_path

        within('#shortest-ride') do
          expect(page).to have_content("Shortest Ride:")
          expect(page).to have_content("Trip: #{trip.id}")
          expect(page).to have_content("Duration: #{trip.duration}")
        end
    end

    it 'they should the station with the most rides as the starting place' do
      @station2 = Station.create!(name:'name',
        dock_count:5,
        city:'denver',
        installation_date:Time.now)
        
      Trip.create(duration: 2313,
          start_date: Time.now,
          bike_id: 12,
          subscription_type: 0,
          zip_code: 23456,
          start_station_id: @station2.id,
          end_station_id: @station2.id,
          end_date: Time.now)

      visit trips_dashboard_path

      expect(page).to have_content("Start Station with Most Rides: #{@station.name}")
    end

    it 'they should see the station with the most rides as the ending place' do
      @station2 = Station.create!(name:'name',
        dock_count:5,
        city:'denver',
        installation_date:Time.now)
        
      Trip.create(duration: 2313,
          start_date: Time.now,
          bike_id: 12,
          subscription_type: 0,
          zip_code: 23456,
          start_station_id: @station2.id,
          end_station_id: @station2.id,
          end_date: Time.now)

      visit trips_dashboard_path

      expect(page).to have_content("End Station with Most Rides: #{@station.name}")
    end

    it 'they should see a month by month breakdown of number of rides with subtotal by year' do
      trip = Trip.create(duration: 1,
        start_date: DateTime.parse('25/10/2012'),
        bike_id: 12,
        subscription_type: 'subscriber',
        zip_code: 23456,
        start_station_id: @station.id,
        end_station_id: @station.id,
        end_date: DateTime.parse('25/10/2012'))

      visit trips_dashboard_path

      expect(page).to have_content("#{DateTime.now.month}: 40")
      expect(page).to have_content("#{DateTime.now.year}: 40")
      expect(page).to have_content("#{trip.start_date.month}: 1")
      expect(page).to have_content("#{trip.start_date.year}: 1")
    end

    it 'they should see the most ridden bike with total number of rides for that bike' do
      trip = Trip.create!(duration: 12,
        start_date: DateTime.parse('02/10/1999'),
        end_date: DateTime.parse('02/10/1999'),
        bike_id: 1,
        subscription_type: 'customer',
        zip_code: 80202,
        start_station_id: @station.id,
        end_station_id: @station.id)

      visit trips_dashboard_path

      expect(page).to have_content("Most Used Bike: #{@trips[0].bike_id} with 3 ride(s)")
    end

    it 'they should see the least ridden bike with total number of rides for that bike' do
      trip = Trip.create!(duration: 12,
        start_date: DateTime.parse('02/10/1999'),
        end_date: DateTime.parse('02/10/1999'),
        bike_id: 102,
        subscription_type: 'customer',
        zip_code: 80202,
        start_station_id: @station.id,
        end_station_id: @station.id)

      visit trips_dashboard_path

      expect(page).to have_content("Least Used Bike: #{trip.bike_id} with 1 ride(s)")
    end

    it 'they should see the user subscription type breakdown, with total and percentage' do
      visit trips_dashboard_path

      within('#subscription-breakdown-container') do
        expect(page).to have_content('Subscriber: 20 at 50%')
        expect(page).to have_content('Customer: 20 at 50%')
      end
    end

    it 'they should see a single date with the highest number of trips and a count of those trips' do
      trip = Trip.create!(duration: 12,
        start_date: DateTime.parse('02/10/1999'),
        end_date: DateTime.parse('02/10/1999'),
        bike_id: 42,
        subscription_type: 'customer',
        zip_code: 80202,
        start_station_id: @station.id,
        end_station_id: @station.id)

      visit trips_dashboard_path

      within('#highest-number-of-trips') do
        expect(page).to have_content("Highest Number of Trips:")
        expect(page).to have_content("Date: #{@trips[0].start_date}")
        expect(page).to have_content("Number of Trips: #{@trips.length}")
      end
    end

    it 'they should see a single date with the lowest number of trips and a count of those trips' do
      trip = Trip.create!(duration: 12,
        start_date: DateTime.parse('02/10/1999'),
        end_date: DateTime.parse('02/10/1999'),
        bike_id: 42,
        subscription_type: 'customer',
        zip_code: 80202,
        start_station_id: @station.id,
        end_station_id: @station.id)

      visit trips_dashboard_path

      within('#lowest-number-of-trips') do
        expect(page).to have_content("Lowest Number of Trips:")
        expect(page).to have_content("Date: #{trip.start_date}")
        expect(page).to have_content("Number of Trips: 1")
      end
    end
  end
end
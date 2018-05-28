require 'rails_helper'

RSpec.feature "Trips Index", type: :feature do
  describe 'A visitor' do
    describe 'visiting the trips index path' do
      describe 'for navigating' do
        before(:all) do
          @station = Station.create!(name:'name',
                                    dock_count:5,
                                    city:'denver',
                                    installation_date:Time.now)
          40.times do |num|
            Trip.create(duration: num,
                        start_date: Time.now,
                        bike_id: num+rand(10),
                        subscription_type: 0,
                        zip_code: 23456,
                        start_station_id: @station.id,
                        end_station_id: @station.id,
                        end_date: Time.now,
                        )
          end
        end
        before(:each) do
          visit(trips_path)
        end
        it 'should show the first 30 trips' do
          expect(page).to have_css("li:nth-child(30)")
          expect(page).to_not have_css("li:nth-child(31)")
        end
        it 'should show pagination buttons' do
          within('.pagination') do
            expect(page).to have_link('Next')
            expect(page).to have_css('.next_page')
            click_on 'Next'
          end

          expect(current_path).to eq(trips_path(page:2))
          expect(page).to have_css('.pagination')
        end
      end
      context 'each trip' do 
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
        before(:each) do
          visit(trips_path)
        end
        it 'should show duration' do
          within('li:nth-child(1)') do
            expect(page).to have_content(@trip1.duration)
          end
        end

        it 'should show start date' do
          within('li:nth-child(1)') do
            save_and_open_page
            expect(page).to have_content(@trip1.start_date)
          end
        end

        it 'should show end date' do
          within('li:nth-child(1)') do
            expect(page).to have_content(@trip1.end_date)
          end
        end

        it 'should show end station' do
          within('li:nth-child(1)') do
            expect(page).to have_content(@station2.name)
          end
        end

        it 'should show start station' do
          within('li:nth-child(1)') do
            expect(page).to have_content(@station1.name)
          end
        end

        it 'should show the bike id' do
          within('li:nth-child(1)') do
            expect(page).to have_content(@trip1.bike_id)
          end
        end

        it 'should show subscription type' do
          within('li:nth-child(1)') do
            expect(page).to have_content(@trip1.subscription_type)
          end
        end

        it 'should show the zip code' do
          within('li:nth-child(1)') do
            expect(page).to have_content(@trip1.zip_code)
          end
        end
      end
    end
  end
end

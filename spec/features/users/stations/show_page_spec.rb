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
        
      end
      it 'should show the number of rides started at that station' do
      end
      it 'should show the Number of rides ended at this station' do
      end
      it 'should show the Most frequent destination station (for rides that began at this station)' do
      end
      it 'should the Most frequent origination station (for rides that ended at this station' do
      end
      it 'should the Date with the highest number of trips started at this station' do
      end
      it 'should the Most frequent zip code for users starting trips at this station' do
      end
      it 'should show the Bike ID most frequently starting a trip at this station.' do
      end
    end
  end
end
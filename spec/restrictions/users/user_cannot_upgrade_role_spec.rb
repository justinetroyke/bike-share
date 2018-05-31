require 'rails_helper'

RSpec.feature 'user restriction' do
  describe 'A User' do
    describe 'attempts to upgrade their role' do
      it 'should be impossible for a normal user to view admin dashboard' do
        user= User.create!(username:'Gnome',
                           first_name:'Dave',
                           last_name:'Thomas',
                           address:'10000000008',
                           password:'agile_is_dead')
        user2= User.create!(username:'Someone else',
                            first_name:'me',
                            last_name:'myself',
                            address:'2 asdf',
                            password:'ghj')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit admin_dashboard_path 
        expect(status_code).to eq(403)

        visit admin_stations_path
        expect(status_code).to eq(403)

        visit admin_trips_path
        expect(status_code).to eq(403)
      end
    end
  end
end

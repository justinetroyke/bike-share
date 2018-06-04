require 'rails_helper'

RSpec.describe 'Station index Page (Admin)' do
  describe 'An Admin' do
    context 'visitng the stations index page' do
      describe 'and clicking the delete button next to the station' do
        it 'should delete the station' do
          admin = User.create!(username:'fmqueen',
                               first_name:'freddy',
                               last_name:'mercury',
                               password:'bohemian',
                               address:'1234 st',
                               role:1)
          station = Station.create(name:'downtown',
                         dock_count:4,
                         city:'denver',
                         installation_date:Time.now)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

          visit stations_path

          click_on('Delete')

          within('table') do
            expect(page).to_not have_content(station.name)
          end
          expect(page).to have_content("#{station.name} Deleted")
        end
      end
    end
  end
end

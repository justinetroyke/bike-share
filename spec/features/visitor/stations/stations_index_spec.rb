require 'rails_helper'

RSpec.feature "Stations Index", type: :feature do
  describe 'A visitor' do
    context 'visiting stations index' do
      it 'should display all relevant info for each station' do
        station1 = Station.create!(name:'downtown',
                                   dock_count: 4,
                                   city: 'denver',
                                   installation_date: Time.now)
        station2 = Station.create!(name:'downtown',
                                   dock_count: 4,
                                   city: 'denver',
                                   installation_date: Time.now)
        
        visit stations_path

        expect(page).to have_content(station1.name)
        expect(page).to have_content(station1.dock_count)
        expect(page).to have_content(station1.city)
        expect(page).to have_content(station1.installation_date.strftime('%d %B %Y'))
        expect(page).to have_content(station2.name)
        expect(page).to have_content(station2.dock_count)
        expect(page).to have_content(station2.city)
      end
    end
  end
end

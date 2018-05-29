require 'rails_helper'

describe 'When you click on a specific station' do
  context 'as a visitor' do
    it 'shows all attributes of station' do
      station = Station.create!(
        name: 'Union Station',
        dock_count: 12,
        city: 'Denver',
        installation_date:Time.now
      )

      visit "/stations/#{station.slug}"

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)
    end

    it 'links to the correct slug name' do
      station = Station.create!(
        name: 'Union Station',
        dock_count: 12,
        city: 'Denver',
        installation_date: Time.now
      )

      visit station_path(station.slug)

      expect(current_path).to eq("/stations/#{station.slug}")
    end
  end
end

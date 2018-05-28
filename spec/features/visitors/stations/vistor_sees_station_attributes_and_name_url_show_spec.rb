require 'rails_helper'

describe 'When you click on a specific station' do
  context 'as a visitor' do
    it 'shows all attributes of station' do
      station = Station.create!(
        name: 'Union Station',
        dock_count: 12,
        city: 'Denver',
        installation_date: DateTime.parse('2010-2-15')
      )

      visit "/#{station.slug}"

      expect(current_page).to have_content(station.name)
      expect(current_page).to have_content(station.dock_count)
      expect(current_page).to have_content(station.city)
      expect(current_page).to have_content(station.installation_date)
    end

    it 'links to the correct slug name' do
      station = Station.create!(
        name: 'Union Station',
        dock_count: 12,
        city: 'Denver',
        installation_date: DateTime.parse('2010-2-15')
      )

      visit stations_path

      expect(current_path).to eq("/#{station.slug}")
    end
  end
end

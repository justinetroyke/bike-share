require 'rails_helper'

RSpec.describe 'Station Show Page (Admin)' do
  before :each do
    @admin = User.create!(role: 1, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
    @station1 = Station.create!(name: 'Union Station', dock_count: 12, city: 'Denver', installation_date: DateTime.now)
    @station2 = Station.create!(name: 'AnotherStation', dock_count: 10, city: 'Not Denver', installation_date: DateTime.now)

  end
  describe 'An admin visits the show page for a specific station' do
    it 'they should see the station\'s name' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit station_path(@station1.slug)

      expect(page).to have_content(@station1.name)
      expect(page).to_not have_content(@station2.name)
    end
    
    it 'they should see the station\'s dock_count' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit station_path(@station1.slug)

      expect(page).to have_content(@station1.dock_count)
      expect(page).to_not have_content("Dock Count: #{@station2.dock_count}")
    end
    
    it 'they should see the station\'s city' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit station_path(@station1.slug)

      expect(page).to have_content(@station1.city)
      expect(page).to_not have_content(@station2.city)
    end
    
    it 'they should see the station\'s installation date' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit station_path(@station1.slug)

      expect(page).to have_content(@station1.installation_date)
    end
    
    it 'they should see a button that deletes the station when clicked on' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit station_path(@station1.slug)

      expect(page).to have_button('Delete')
      click_button 'Delete'
      expect(page).to have_current_path(stations_path)
      within('content') do
        expect(page).to_not have_content(@station1.name)
        expect(page).to have_content(@station2.name)
      end
    end
    
    it 'they should see a button for editing the station that takes them to the edit station for that page' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit station_path(@station1.slug)

      expect(page).to have_button('Edit')
      click_button 'Edit'
      expect(page).to have_current_path(edit_admin_station_path(@station1))
      expect(page).to have_content("Edit #{@station1.name}")
      expect(page).to_not have_content("Edit #{@station2.name}")
    end
  end
end

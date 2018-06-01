require 'rails_helper'

RSpec.describe 'Station Edit Page (Admin)' do
  before :each do
    @admin = User.create!(role: 1, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
    @station1 = Station.create!(name: 'Union Station', dock_count: 12, city: 'Denver', installation_date: DateTime.now)
    @station2 = Station.create!(name: 'AnotherStation', dock_count: 10, city: 'Not Denver', installation_date: DateTime.now)
  end
  describe 'An admin edits a station' do
    it 'should got to show page with updates' do
      new_name = '16th street mall'
      new_dock_count = 2
      new_city = 'Golden'
      new_installation_date = DateTime.now
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit station_path(@station1.slug)

      expect(page).to have_button('Edit')
      click_button 'Edit'

      fill_in 'station[name]', with: new_name
      fill_in 'station[dock_count]', with: new_dock_count
      fill_in 'station[city]', with: new_city
      fill_in 'station[installation_date]', with: new_installation_date
      click_button 'Update Station'

      expect(current_path).to eq(station_path("16th-street-mall"))
      expect(page).to have_content(new_dock_count)
      expect(page).to have_content(new_city)
      expect(page).to have_content(new_installation_date.strftime("%B%e, %Y"))
    end
  end
end

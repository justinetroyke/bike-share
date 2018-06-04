require 'rails_helper'

RSpec.describe 'Station New Page (Admin)' do
  before :each do
    @admin = User.create!(role: 1, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  describe 'An admin creates a station' do
    it 'should click link through admin dashboard' do
      new_name = '16th street mall'
      new_dock_count = 2
      new_city = 'Golden'
      new_installation_date = DateTime.now.strftime("%B%e, %Y")

      visit admin_dashboard_path

      expect(page).to have_link('Create New Station')
      click_link 'Create New Station'

      fill_in 'station[name]', with: new_name
      fill_in 'station[dock_count]', with: new_dock_count
      fill_in 'station[city]', with: new_city
      fill_in 'station[installation_date]', with: new_installation_date
      click_button 'Create Station'

      expect(current_path).to eq(station_path("16th-street-mall"))
      expect(page).to have_content(new_dock_count)
      expect(page).to have_content(new_city)
      expect(page).to have_content(new_installation_date)
    end

    it 'should click link through admin dashboard' do
      new_name = '16th street mall'
      new_dock_count = 2
      new_city = 'Golden'
      new_installation_date = DateTime.now.strftime("%B%e, %Y")

      visit stations_path

      expect(page).to have_link('Create New Station')
      click_link 'Create New Station'

      fill_in 'station[name]', with: new_name
      fill_in 'station[dock_count]', with: new_dock_count
      fill_in 'station[city]', with: new_city
      fill_in 'station[installation_date]', with: new_installation_date
      click_button 'Create Station'

      expect(current_path).to eq(station_path("16th-street-mall"))
      expect(page).to have_content(new_dock_count)
      expect(page).to have_content(new_city)
      expect(page).to have_content(new_installation_date)
    end
  end
end

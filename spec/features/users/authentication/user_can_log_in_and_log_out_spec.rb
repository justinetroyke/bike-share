require 'rails_helper'

describe 'Visitor' do
  context 'logs in' do
    it 'should log in the member' do
      username = 'pizza_cat'
      password = 'password'
      role = 0
      address = '123 Chestnut Pl, Denver CO 80202'
      first = 'Kirk'
      last = 'Spock'
      user = User.create!(
        username: username,
        password: password,
        role: role,
        address: address,
        first_name: first,
        last_name: last
      )

      visit root_path

      expect(page).to have_content('Log In')

      click_link 'Log In'

      expect(current_path).to eq(login_path)

      fill_in :username, with: username
      fill_in :password, with: password
      within('form') do
        click_on 'Log In'
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as #{user.username}")
      expect(page).to have_content("#{user.address}")
      expect(page).to have_content("#{user.first_name}")
      expect(page).to have_content("#{user.last_name}")
      expect(page).to have_content('Log Out')

      click_on 'Log Out'
      expect(current_path).to eq(root_path)
    end
  end

  context 'not logged in' do
    it 'is unable to see dashboard' do
      username = 'pizza_cat'
      password = 'password'
      role = 0
      address = '123 Chestnut Pl, Denver CO 80202'
      first = 'Kirk'
      last = 'Spock'
      user = User.create!(
        username: username,
        password: password,
        role: role,
        address: address,
        first_name: first,
        last_name: last
      )

      visit dashboard_path
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Looks like you may need to log in!")
    end
  end
end

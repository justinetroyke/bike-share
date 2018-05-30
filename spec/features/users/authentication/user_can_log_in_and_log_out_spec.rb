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

      visit '/'

      expect(current_page).to have_content('Log in')

      click_link 'Log in'

      expect(current_path).to eq(login_path)

      fill_in :username, with: name
      fill_in :password, with: pass
      within('#login_form') do
        click_on 'Log in'
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as #{user.username}")
      expect(page).to have_content("Logged in as #{user.address}")
      expect(page).to have_content("Logged in as #{user.first_name}")
      expect(page).to have_content("Logged in as #{user.last_name}")
      expect(page).to have_content('Log out')

      click_on 'Log out'
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
    end
  end
end

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

      expect(current_page).to eq('Log in')

      click_link 'Log in'

      expect(current_path).to eq(login_path)

      fill_in :username, with: name
      fill_in :password, with: pass
      within('#login_form') do
        click_on 'Log in'
      end

      expect(current_path).to eq(user_path(user))
      expect(page).to have_content('Log out')

      click_on 'Log out'
      expect(current_path).to eq(root_path)
    end
  end

  it 'should not allow duplicate usernames' do
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

    
  end
end
# As a registered user,
#
# When I visit /,
# I see a link for Login,
# When I click Login,
#
# I should be on the /login page,
# I see a place to insert my credentials to login,
# I fill in my desired credentials,
# I submit my information,
# My current page should be /dashboard,
# I see a message in the navbar that says Logged in as SOME_USER,
# I see my profile information,
# I do not see a link for Login,
# I see a link for Logout.

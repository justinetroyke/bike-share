require 'rails_helper'

RSpec.feature "New account", type: :feature do
  describe 'A visitor' do
    context 'visiting the new account path' do
      it 'should have fields to enter credentials' do
        visit new_user_path

        expect(page).to have_field('user[username]')
        expect(page).to have_field('user[password]')
        expect(page).to have_field('user[first_name]')
        expect(page).to have_field('user[last_name]')
        expect(page).to have_field('user[address]')
      end
    end

    context 'and entering in the neccesary credentials' do
      it 'should redirect to the dashboard and show the profile info' do

        username = 'JimBUser'
        password = 'password'
        first_name = 'Jim'
        last_name = 'User'
        address = '1234 something street'

        visit new_user_path

        fill_in 'user[username]', with: username
        fill_in 'user[first_name]', with: first_name
        fill_in 'user[last_name]', with: last_name
        fill_in 'user[address]', with: address
        fill_in 'user[password]', with: password
        within('form') do
          click_on 'Create Account'
        end

        expect(current_path).to eq(dashboard_path)

        within('header') do
          expect(page).to have_content("Logged in as #{username}")
        end
        expect(page).to have_content(username)
        expect(page).to have_content(first_name)
        expect(page).to have_content(last_name)
        expect(page).to have_content(address)
        expect(page).to_not have_link('Log In')
        expect(page).to have_link('Log Out')
      end
    end
  end
end


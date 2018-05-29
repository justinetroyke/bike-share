require 'rails_helper'

RSpec.feature "An Admin Logs in", type: :feature do
  describe 'An unauthenticated admin' do
    context 'visiting the root path' do
      it 'should show a link for login' do
        visit root_path
        expect(page).to have_link('Log In')
      end
    end
    context 'visits the login page' do
      it 'should show the relevant user information and not show log in' do
        @password = 'password'
        @username = 'user'
        @admin = User.create!(username: @username,
                        password: @password,
                        last_name: 'ever',
                        first_name:'greatest',
                        address:'1234 awesome street',
                        role:1)
        visit root_path
        click_on 'Log In'

        expect(current_path).to eq(login_path)
        expect(page).to have_field('username')
        expect(page).to have_field('password')
        fill_in ('username'), with: @username
        fill_in ('password'), with: @password
        within 'content' do
          click_on('Log In')
        end

        expect(current_path).to eq(admin_dashboard_path)
        expect(page).to have_content("Logged in as Admin User: #{@admin.username}")
        expect(page).to have_content(@admin.first_name)
        expect(page).to have_content(@admin.username)
        expect(page).to have_content(@admin.last_name)
        expect(page).to have_content(@admin.address)
        expect(page).to_not have_link('Log In')
        expect(page).to have_link('Log Out')
      end
    end
  end
end

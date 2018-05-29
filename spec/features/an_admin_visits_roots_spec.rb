require 'rails_helper'

RSpec.feature "An Admin Logs in", type: :feature do
  describe 'An unauthenticated admin' do
    before (:all) do 
      @password = 'password'
      @admin = User.new(username:'username',
                       password:password,
                       last_name: 'ever',
                       first_name:'greatest',
                       address:'1234 awesome street',
                       role:1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(:@admin)
    end
    context 'visiting the root path' do
      it 'should show a link for login' do
        visit root_path
        expect(page).to have_link('Log In')
      end
    end
    context 'visits the login page' do
      visit root_path
      click_on 'Log In'

      expect(current_path).to eq(login_path)
      fill_in :username, with: admin.username
      fill_in :password, with: @password
      click_on('Log In')

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Logged in as Admin User: #{admin.username}")
      expect(page).to have_content(admin.first_name)
      expect(page).to have_content(admin.username)
      expect(page).to have_content(admin.last_name)
      expect(page).to have_content(admin.address)
      expect(page).to_not have_link('Log In')
      expect(page).to have_link('Log Out')
    end
  end
end

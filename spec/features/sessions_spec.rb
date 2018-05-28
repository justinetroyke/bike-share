require 'rails_helper'

RSpec.describe 'Sessions' do
  describe 'A user click the \'Log \'In button' do
    it 'should have user_id in session and current user should exist' do
      visit root_path

      click_link 'Log In'

      fill_in 'user[username]', with: @spec_user1.username
      fill_in 'user[password]', with: @spec_user1.password
      click_button 'Log In'

      expect(current_user).to_not eq(nil)
      expect(session[:user_id]).to eq(current_user.id)
    end

    it 'the nav should have a \'Log Out\' button' do
      visit root_path

      click_link 'Log In'

      fill_in 'user[username]', with: @spec_user1.username
      fill_in 'user[password]', with: @spec_user1.password
      click_button 'Log In'

      expect(page).to have_link('Log Out')
    end
  end

  describe 'A user clicks the \'Log Out\' button' do
    it 'current user should be nil and page should have \'Log In\' and \'Create Account\' buttons' do
      visit root_path

      click_link 'Log In'

      fill_in 'user[username]', with: @spec_user1.username
      fill_in 'user[password]', with: @spec_user1.password
      click_button 'Log In'

      click_link 'Log Out'

      expect(page).to have_current_path(root_path)
      expect(current_user).to eq(nil)
      expect(session[:user_id]).to eq(nil)
    end
  end
end
require 'rails_helper'
RSpec.feature "Log In", type: :feature do
  describe 'A Visitor' do 
    context 'visiting root' do 
      it 'should see a link for login' do
        visit root_path
        expect(page).to have_link('Log In')
      end
      it 'should redirect to the login page' do
        visit root_path
        click_on('Log In')
        expect(current_path).to eq(login_path)
      end
    end
    context 'visiting the login path' do 
      it 'should have a link to create a new account' do
        visit login_path
        expect(page).to have_link('Create Account')
      end
    end
  end
end
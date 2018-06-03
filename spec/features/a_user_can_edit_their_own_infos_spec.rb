require 'rails_helper'

RSpec.feature "AUserCanEditTheirOwnInfos", type: :feature do
  describe 'A registered User' do
    describe 'visitng edit user path' do
      it 'should allow a user to edit their own info' do 
        password = 'Penelope'
        @user = User.create!(username:'oudeis',
                           first_name:'odysseus',
                           last_name:'n/a',
                           role:0,
                           password: password,
                           address:'most places eventually')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit edit_user_path(@user)

        new_address = 'Home'
        
        fill_in 'user[address]', with: new_address
        fill_in 'user[password]', with: password
        fill_in 'user[password_confirmation]', with: password
        click_on('Update User')

        expect(current_path).to eq(dashboard_path)
        expect(User.find(@user.id).address).to eq(new_address)
      end
      it 'should not allow a user to edit other peoples info' do
        user = User.create!(username:'oudeis',
                          first_name:'odysseus',
                          last_name:'n/a',
                          role:0,
                          password:'Penelope',
                          address:'most places eventually')
        user2 = User.create!(username:'homebody',
                            first_name:'auto',
                            last_name:'lykos',
                            role:0,
                            password:'slacker',
                            address:'mostly in the fields')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        
        visit edit_user_path(user2)
        expect(status_code).to eq(403)
      end
    end
  end
end

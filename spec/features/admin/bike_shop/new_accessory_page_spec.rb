require 'rails_helper'

RSpec.describe 'New Accessory Page (Admin)' do
  describe 'An admin visits the new accessory page' do
    it 'they should be able to create a new accessory' do
      visit new_admin_accessory_path


      new_accessory_title = 'New Title'
      new_accessory_description = 'This is a new accessory'
      new_accessory_price = 8

      fill_in 'accessory[title]', with: new_accessory_title
      fill_in 'accessory[description]', with: new_accessory_description
      fill_in 'accessory[price]', with: new_accessory_price
      click_button 'Create Accessory'

      save_and_open_page

      expect(page).to have_current_path(accessory_path(Accessory.last))
      expect(page).to have_content(new_accessory_title)
      expect(page).to have_content(new_accessory_description)
      expect(page).to have_content(new_accessory_price)
      expect(page).to have_css("img[src='default/image1']")
    end
  end
end

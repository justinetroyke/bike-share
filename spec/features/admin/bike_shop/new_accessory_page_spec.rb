require 'rails_helper'

RSpec.describe 'New Accessory Page (Admin)' do
  describe 'An admin visits the new accessory page' do
    it 'they should be able to create a new accessory' do
      visit new_admin_accessory_path


      new_item_title = 'New Title'
      new_item_description = 'This is a new item'
      new_item_price = 8

      fill_in 'item[title]', with: new_item_title
      fill_in 'item[description]', with: new_item_description
      fill_in 'item[price]', with: new_item_price
      click_button 'Create Item'

      expect(page).to have_current_path(accessory_path(Item.last))
      expect(page).to have_content(new_item_title)
      expect(page).to have_content(new_item_description)
      expect(page).to have_content(new_item_price)
      expect(page).to have_css("img[src='default/image1']")
    end
  end
end

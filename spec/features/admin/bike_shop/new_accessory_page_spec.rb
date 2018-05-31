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

      expect(page).to have_current_path(accessory_path(Accessory.last))
      expect(page).to have_content(new_accessory_title)
      expect(page).to have_content(new_accessory_description)
      expect(page).to have_content(new_accessory_price)
      expect(page.find('img')['src']).to have_content('assets/image1')
    end
  end

  it 'they should only create accessories with unique titles' do
    visit new_admin_accessory_path
    
    Accessory.create!(title: 'Unique Title', price: '1.23', description: 'This is a cool accessory')
    
    fill_in 'accessory[title]', with: 'Unique Title'
    fill_in 'accessory[description]', with: 'New description'
    fill_in 'accessory[price]', with: '4.23'
    click_button 'Create Accessory'
    
    expect(page).to have_current_path(admin_accessories_path)
    expect(page).to have_content('Sorry! That title has already been taken. Please choose another.')
  end
  
  it 'they should only be able to create an item with a valid numeral' do
    visit new_admin_accessory_path


    fill_in 'accessory[title]', with: 'Unique Title'
    fill_in 'accessory[description]', with: 'New description'
    fill_in 'accessory[price]', with: '-4.8'
    click_button 'Create Accessory'

    expect(page).to have_current_path(admin_accessories_path)
    expect(page).to have_content('Please enter a valid decimal numeral value for your price. It must also be greater than zero.')

    visit new_admin_accessory_path


    fill_in 'accessory[title]', with: 'Unique Title'
    fill_in 'accessory[description]', with: 'New description'
    fill_in 'accessory[price]', with: 'hello'
    click_button 'Create Accessory'

    expect(page).to have_current_path(admin_accessories_path)
    expect(page).to have_content('Please enter a valid decimal numeral value for your price. It must also be greater than zero.')
  end
end

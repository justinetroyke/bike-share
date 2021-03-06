require 'rails_helper'

RSpec.describe 'Visitor Cart Page' do
  before :each do
    @image_url = 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
    @accessory1 = Accessory.create!(title: 'Accessory 1', price: 1, description: 'This is accessory one', image_url: @image_url)
    @accessory2 = Accessory.create!(title: 'Accessory 2', price: 2, description: 'This is accessory two', image_url: @image_url)
  end
  describe 'Clicks on their cart' do
    it 'they should see an image, title, description, and price for my accessory' do
      visit accessory_path(@accessory2)
      click_button 'Add to Cart'
      visit accessory_path(@accessory2)
      click_button 'Add to Cart'
      visit accessory_path(@accessory1)
      click_button 'Add to Cart'

      visit '/cart'

      within ('#cart-contents-container') do
        expect(page).to have_content(2)
      end

      visit accessory_path(@accessory2)
      click_button 'Add to Cart'
      visit '/cart'

      within ('#cart-contents-container') do
        expect(page).to have_content(3)
      end
      within ('#cart-contents-container') do
        expect(page).to have_content("$6")
      end
      expect(page).to have_content("Total: $7")
    end
  end
end

require 'rails_helper'

RSpec.describe 'Accessory Show Page' do
  before :each do
    @accessory1 = Item.create!(title: 'Accessory 1', price: 1, description: 'This is accessory one', image: 'default/accessory1')
    @accessory2 = Item.create!(title: 'Accessory 2', price: 2, description: 'This is accessory two', image: 'default/accessory2')
  end
  describe 'A visitor visits the show page for a specific accessory' do
    it 'they should see an image, title, description, and price for my accessory' do
      visit accessory_path(@accessory1)
      
      expect(page).to have_content(@accessory1.title)
      expect(page).to have_content(@accessory1.description)
      expect(page).to have_content(@accessory1.price)
      expect(page).to have_css("img[src='default/accessory1']")
      
      expect(page).to_not have_content(@accessory2.title)
      expect(page).to_not have_content(@accessory2.description)
      expect(page).to_not have_content(@accessory2.price)
      expect(page).to_not have_css("img[src='default/accessory2']")
    end

    it 'they should be able to click \'Add to Cart\'' do
      visit accessory_path(@accessory2)

      click_button 'Add to Cart'

      expect(page).to have_current_path(accessory_path(@accessory2))
      expect(page).to have_content("1 #{@accessory2} has been add to the cart!")
      expect(page).to have_content("Cart: 1")
    end
  end
end
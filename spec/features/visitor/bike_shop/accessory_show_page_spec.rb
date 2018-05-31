require 'rails_helper'

RSpec.describe 'Accessory Show Page' do
  before :each do
    @image_url = 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
    @accessory1 = Item.create!(title: 'Accessory 1', price: 1, description: 'This is accessory one', image_url: @image_url)
    @accessory2 = Item.create!(title: 'Accessory 2', price: 2, description: 'This is accessory two', image_url: @image_url)
  end
  describe 'A visitor visits the show page for a specific accessory' do
    it 'they should see an image, title, description, and price for my accessory' do
      visit accessory_path(@accessory1)

      expect(page).to have_content(@accessory1.title)
      expect(page).to have_content(@accessory1.description)
      expect(page).to have_content(@accessory1.price)
      expect(page).to have_xpath("//img[contains(@src, @image_url)]")

      expect(page).to_not have_content(@accessory2.title)
      expect(page).to_not have_content(@accessory2.description)
      expect(page).to_not have_content(@accessory2.price)
    end

    it 'they should be able to click \'Add to Cart\'' do
      visit accessory_path(@accessory2)

      click_link 'Add to Cart'

      expect(page).to have_current_path(accessories_path)
      expect(page).to have_content("1 #{@accessory2.title} has been added to your cart!")
      expect(page).to have_content("Cart: 1")
    end
  end
end

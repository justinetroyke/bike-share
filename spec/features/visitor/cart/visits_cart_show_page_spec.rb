require 'rails_helper'

RSpec.describe 'Visitor Cart Page' do
  before :each do
    @image_url = 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
    @accessory1 = Accessory.create!(title: 'Accessory 1', price: 1, description: 'This is accessory one', image_url: @image_url)
    @accessory2 = Accessory.create!(title: 'Accessory 2', price: 12, description: 'This is accessory two', image_url: @image_url)
  end
  describe 'Clicks on their cart' do
    it 'they should see an image, title, description, and price for my accessory' do
      visit accessory_path(@accessory2)
      click_link 'Add to Cart'

      visit '/cart'

      expect(page).to have_content(@accessory2.title)
      expect(page).to have_content(@accessory2.description)
      expect(page).to have_content(@accessory2.price)
      expect(page).to have_xpath("//img[contains(@src, @image_url)]")
      expect(page).to have_content("Subtotal: 12")
      expect(page).to have_content("Total: $12")
    end
  end
  describe 'visitor registers after adding items to cart' do
    it 'they should still see their items' do
      username = 'JimBUser'
      password = 'password'
      first_name = 'Jim'
      last_name = 'User'
      address = '1234 something street'

      visit accessory_path(@accessory1)
      click_link 'Add to Cart'
      visit accessory_path(@accessory2)
      click_link 'Add to Cart'

      visit '/cart'

      expect(page).to have_content(@accessory2.title)
      expect(page).to have_content(@accessory2.description)
      expect(page).to have_content(@accessory2.price)
      expect(page).to have_xpath("//img[contains(@src, @image_url)]")
      expect(page).to have_content("Total: $1")

      visit new_user_path

      fill_in 'user[username]', with: username
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[address]', with: address
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      within('form') do
        click_on 'Create Account'
      end

      visit '/cart'
      save_and_open_page

      expect(page).to have_content(@accessory2.title)
      expect(page).to have_content(@accessory2.description)
      expect(page).to have_content(@accessory2.price)
      expect(page).to have_xpath("//img[contains(@src, @image_url)]")
      expect(page).to have_content("Total: $1")
    end
  end
end

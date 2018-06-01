require 'rails_helper'

RSpec.describe 'Cart Page' do
  before :each do
    @accessories = []
    3.times do |num|
      @accessories << Accessory.create!(title: "Accessory #{num}", price: (num + 1), description: "This is accessory #{num}")
    end
    # Should be an anonymous visitor
    visit accessories_path

    within("#accessory-#{@accessories[0].id}") do
      click_link 'Add to Cart'
    end

  end
  describe 'A visitor visits the cart page after adding items to the cart' do
    it 'the cart count should reflect the number of items in the cart' do
      visit cart_path

      within('#cart-count') do
        expect(page).to have_content('1')
      end
    end

    it 'should have the item added to the cart and the correct quantity' do
      visit cart_path

      expect(page).to have_content(@accessories[0].title)
      expect(page).to have_content('Quanitity: 1')
      expect(page).to have_content("Subtotal: #{@accessories[0].price}")
    end

    it 'should decrease the cart count after removing an item' do
      visit cart_path

      within("#cart-accessory-#{@accessories[0].id}") do
        click_link 'Remove from Cart'
      end

      expect(page).to have_current_path(cart_path)
      expect(page).to_not have_content(@accessories[0].title)
      expect(page).to have_content('Your cart is currently empty.')
      within('#cart-count') do
        expect(page).to have_content('0')
      end
    end

    it 'should properly reflect decrease in cart count, item quantity, and item subtotal after removing an item' do
      within("#accessory-#{@accessories[0].id}") do
        click_link 'Add to Cart'
      end

      visit cart_path

      within('#cart-count') do
        expect(page).to have_content(2)
      end

      within("#cart-accessory-#{@accessories[0].id}") do
        expect(page).to have_content('Quantity: 2')
        expect(page).to have_content("Subtotal: #{@accessories[0].price * 2}")

        click_link 'Remove from Cart'
      end

      expect(page).to have_current_path(cart_path)
      expect(page).to have_content(@accessories[0].title)
      expect(page).to have_content('Quanitity: 1')
      expect(page).to have_content("Subtotal: #{@accessories[0].price}")
      within('#cart-count') do
        expect(page).to have_content(1)
      end
    end
  end
end
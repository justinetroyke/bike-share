require 'rails_helper'

RSpec.describe 'Order Show Page (Admins)' do
  before :each do
    # Sets up user, order, and items to be tested for
    @image_url = 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
    @user1 = User.create!(role: 0, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
    @order1 = @user1.orders.create!(status: 'ordered')
    @accessory1 = @order1.accessories.create!(title: 'Item 1', price: 1, description: 'This is item 1', image_url: @image_url)
    @accessory2 = @order1.accessories.create!(title: 'Item 2', price: 2, description: 'This is item 2', image_url: @image_url)

    # Sets up user, order, and items to ensure are not present
    @user2 = User.create!(role: 0, username: 'user2', password: 'user2spassword', address: '222 Not An Address', first_name: 'User', last_name: 'Two')
    @order2 = @user2.orders.create!(status: 'paid')
    @accessory3 = @order2.accessories.create!(title: 'Item 3', price: 3, description: 'This is item 3', image_url: @image_url)

    # Visits each page for these sort of separate tests
    visit order_path(@order1)
  end

  describe 'An admin visits an individual order\'s show page' do
    it 'they should see the order\'s date and time' do
      expect(page).to have_content(@order1.created_at.strftime("Ordered: %B %e, %Y at%l:%M%p"))
      # expect(page).to_not have_content(@order2.created_at.strftime("Ordered: %B %e, %Y at%l:%M%p"))
    end

    it 'they should see the purchaser\'s full name and address' do
      expect(page).to have_content("Ordered By: #{@order1.user.first_name} #{@order1.user.last_name}")

      expect(page).to_not have_content("Ordered By: #{@order2.user.first_name} #{@order2.user.last_name}")
    end

    it 'they should see the items\' names as a links to the items\' respective show pages' do
      @order1.accessories.each do |item|

        expect(page).to have_link(item.title)
        click_link item.title
        expect(current_path).to eq(accessory_path(item))
        visit order_path(@order1)
      end
    end

    it 'they should the quantity in this order' do
      expect(page).to have_content("Quantity: #{@order1.accessories.count}")

      expect(page).to_not have_content("Quantity: #{@order2.accessories.count}")
    end

    it 'they should see the line item subtotal' do
      @order1.accessories.each do |accessory|
        within("#order-accessory-#{accessory.id}") do
          # Test the subtotal based on the number of a given item times its base price
          expect(page).to have_content("Subtotal: #{@order1.accessories.where(id: accessory.id).sum(:price)}")
        end
      end
    end

    it 'they should see the total for the order' do
      expect(page).to have_content("Total: #{@order1.accessories.sum(:price)}")
    end

    it 'they should see the status for the order' do
      expect(page).to have_content("Status: #{@order1.status}")
    end
  end
end

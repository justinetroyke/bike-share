require 'rails_helper'

RSpec.describe 'Order Show Page (Admins)' do
  before :each do
    # Sets up user, order, and items to be tested for
    @user1 = User.create!(role: 0, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
    @order1 = @user1.orders.create!(status: 'ordered', quantity: 3)
    @item1 = @order1.items.create!(title: 'Item 1', price: 1, description: 'This is item 1', image: 'default/image1')
    @item2 = @order1.items.create!(title: 'Item 2', price: 2, description: 'This is item 2', image: 'default/image2')
    OrderItems.create!(order_id: @order1.id, item_id: @item2.id)

    # Sets up user, order, and items to ensure are not present
    @user2 = User.create!(role: 0, username: 'user2', password: 'user2spassword', address: '222 Not An Address', first_name: 'User', last_name: 'Two')
    @order2 = @user2.orders.create!(status: 'paid', quantity: 2)
    @item3 = @order2.items.create!(title: 'Item 3', price: 3, description: 'This is item 3', image: 'default/image3')
    OrderItems.create!(order_id: @order2.id, item_id: @item2.id)

    # Visits each page for these sort of separate tests
    visit order_path(@order1)
  end

  describe 'An admin visits an individual order\'s show page' do
    it 'they should see the order\'s date and time' do
      expect(page).to have_content(@order1.created_at.strftime("Ordered: %B %e, %Y at %l:%M%p"))

      expect(page).to_not have_content(@order2.created_at.strftime("Ordered: %B %e, %Y at %l:%M%p"))
    end

    it 'they should see the purchaser\'s full name and address' do
    end

    it 'they should see the items\' names as a links to the items\' respective show pages' do
    end

    it 'they should the quantity in this order' do
    end

    it 'they should see the line item subtotal' do
    end

    it 'they should see the order for the total' do
    end

    it 'they should see the status for the order' do
    end
  end
end
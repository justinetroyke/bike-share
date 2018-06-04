require 'rails_helper'

RSpec.describe 'Order Show Page (Users)' do
  before :each do
    # Sets up user, order, and items to be tested for
    @image_url = 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
    @user1 = User.create!(role: 0, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
    @order1 = @user1.orders.create!(status: 'ordered')
    @accessory1 = @order1.accessories.create!(title: 'Item 1', price: 1, description: 'This is item 1', image_url: @image_url)
    @accessory2 = @order1.accessories.create!(title: 'Item 2', price: 2, description: 'This is item 2', image_url: @image_url)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    # Sets up user, order, and items to ensure are not present
    @user2 = User.create!(role: 0, username: 'user2', password: 'user2spassword', address: '222 Not An Address', first_name: 'User', last_name: 'Two')
    @order2 = @user2.orders.create!(status: 'paid')
    @accessory3 = @order2.accessories.create!(title: 'Item 3', price: 5, description: 'This is item 3', image_url: @image_url)

    visit order_path(@order1)
  end

  describe 'A user visits an individual order\'s show page' do
    it 'the path should be should be /orders/:id' do

      expect(current_path).to eq("/orders/#{@order1.id}")
    end

    it 'should show accessories subtotals and quantities' do

      expect(page).to have_content('Subtotal: 2.0')
      expect(page).to have_content('Subtotal: 1.0')
      expect(page).to have_content('Quantity: 2')
    end

    it 'should show order total' do

      expect(page).to have_content(@order1.total)
      expect(page).to_not have_content(@order2.total)
    end

    it 'shows order status and date/time' do

      expect(page).to have_content(@order1.status)
      expect(page).to_not have_content(@order2.status)
      expect(page).to have_content(@order1.created_at.strftime("Ordered: %B%e, %Y at%l:%M%p"))
      expect(page).to_not have_content(@order2.created_at.strftime("Ordered: %B %e, %Y at%l:%M%p"))
    end
  end
end

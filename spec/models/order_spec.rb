require 'rails_helper'

RSpec.describe Order do
  describe 'Validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'Relationships' do
    it { should belong_to(:user) }
    it { should have_many(:order_accessories)}
    it { should have_many(:accessories)}
  end

  describe 'instance methods' do
    describe '.total' do
      it 'should show the total price of that order' do
        @image_url = 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
        @user1 = User.create!(role: 0, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
        @order1 = @user1.orders.create!(status: 'ordered')
        @accessory1 = @order1.accessories.create!(title: 'accessory 1', price: 3000, description: 'This is accessory 1', image_url: @image_url)
        @accessory2 = @order1.accessories.create!(title: 'accessory 2', price: 2000, description: 'This is accessory 2', image_url: @image_url)

        expect(@order1.total).to eq(5000)
      end
    end
    describe '.quantity' do
      it 'should return the number of accessories in that order' do
        @image_url = 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
        @user1 = User.create!(role: 0, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
        @order1 = @user1.orders.create!(status: 'ordered')
        @accessory1 = @order1.accessories.create!(title: 'accessory 1', price: 3000, description: 'This is accessory 1', image_url: @image_url)
        @accessory2 = @order1.accessories.create!(title: 'accessory 2', price: 2000, description: 'This is accessory 2', image_url: @image_url)

        expect(@order1.quantity).to eq(2)
        @accessory3 = @order1.accessories.create!(title: 'accessory 3', price: 3000, description: 'This is accessory 3', image_url: @image_url)

        expect(@order1.quantity).to eq(3)
      end
    end
    describe '.accessories_with_subtotal' do
      it 'should return a hash of relevant accessories, with their subtotals' do
        @image_url = 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
        @user1 = User.create!(role: 0, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
        @order1 = @user1.orders.create!(status: 'ordered')
        @accessory1 = @order1.accessories.create!(title: 'accessory 1', price: 3000, description: 'This is accessory 1', image_url: @image_url)
        @accessory2 = @order1.accessories.create!(title: 'accessory 2', price: 2000, description: 'This is accessory 2', image_url: @image_url)
        OrderAccessory.create!(accessory_id:@accessory1.id, order_id:@order1.id)

        expect(@order1.accessories_with_subtotal[@accessory1.id]).to eq(6000)
        expect(@order1.accessories_with_subtotal[@accessory2.id]).to eq(2000)
      end
    end
  end
  describe 'class methods' do
    before(:all) do 
      @image_url = 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
      @user1 = User.create!(role: 0, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
      @order1 = @user1.orders.create!(status:0)
      @accessory1 = @order1.accessories.create!(title: 'Item 1', price: 1, description: 'This is item 1', image_url: @image_url)

      @user2 = User.create!(role: 0, username: 'user2', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
      @order2 = @user2.orders.create!(status:1)
      @order2.accessories.create!(title: 'Item 2', price: 1, description: 'This is item 1', image_url: @image_url)

      @user2 = User.create!(role: 0, username: 'user3', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
      @order4 = @user2.orders.create!(status:1)
      @order4.accessories.create!(title: 'Item 5', price: 1, description: 'This is item 1', image_url: @image_url)

      @user3 = User.create!(role: 0, username: 'user4', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
      @order3 = @user3.orders.create!(status:2)
      @order3.accessories.create!(title: 'Item 3', price: 1, description: 'This is item 1', image_url: @image_url)

      @user4 = User.create!(role: 0, username: 'user5', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
      @order4 = @user4.orders.create!(status:3)
      @order4.accessories.create!(title: 'Item 4', price: 1, description: 'This is item 1', image_url: @image_url)
    end
    
    describe 'self.ordered' do
      it 'shoud return all orders with a status of ordered' do
        Order.ordered.each do |order|
          expect(order.status).to eq('Ordered')
        end
      end
    end
    describe 'self.cancelled' do
      it 'shoud return all orders with a status of cancelled' do
        Order.cancelled.each do |order|
          expect(order.status).to eq('Cancelled')
        end 
      end
    end
    describe 'self.paid' do
      it 'shoud return all orders with a status of paid' do
        Order.paid.each do |order|
          expect(order.status).to eq('Paid')
        end
      end
    end
    describe 'self.completed' do
      it 'shoud return all orders with a status of completed' do
        expect(Order.completed)
        Order.completed.each do |order|
          expect(order.status).to eq('Completed')
        end
      end
    end
  end
end

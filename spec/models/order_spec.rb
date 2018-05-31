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
end

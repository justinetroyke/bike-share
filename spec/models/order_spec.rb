require 'rails_helper'

RSpec.describe Order do
  describe 'Validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'Relationships' do
    it { should belong_to(:user) }
    it { should have_many(:order_items)}
    it { should have_many(:items)}
  end

  describe 'instance methods' do
    describe '.total' do
      it 'should show the total price of that order' do
        @user1 = User.create!(role: 0, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
        @order1 = @user1.orders.create!(status: 'ordered')
        @item1 = @order1.items.create!(title: 'Item 1', price: 3000, description: 'This is item 1', image: 'default/image1')
        @item2 = @order1.items.create!(title: 'Item 2', price: 2000, description: 'This is item 2', image: 'default/image2')

        expect(@order1.total).to eq(5000)
      end
    end
    describe '.quantity' do
      it 'should return the number of items in that order' do
        @user1 = User.create!(role: 0, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
        @order1 = @user1.orders.create!(status: 'ordered')
        @item1 = @order1.items.create!(title: 'Item 1', price: 3000, description: 'This is item 1', image: 'default/image1')
        @item2 = @order1.items.create!(title: 'Item 2', price: 2000, description: 'This is item 2', image: 'default/image2')

        expect(@order1.quantity).to eq(2)
        @item3 = @order1.items.create!(title: 'Item 3', price: 3000, description: 'This is item 3', image: 'default/image3')

        expect(@order1.quantity).to eq(3)
      end
    end
  end
end

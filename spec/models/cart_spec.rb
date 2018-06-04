require 'rails_helper'

RSpec.describe Cart do

  describe "instance methods" do
    describe 'total_count' do
      it "can calculate the total number of accessories it holds" do
        cart = Cart.new('contents' => {"1" => 2, "2" => 3})

        expect(cart.total_count).to eq(5)
      end
    end

    describe 'accessory_count' do
      it 'returns the amount of a certain accesory' do
        cart = Cart.new('contents' => {'1' => 1, '2' => 3})

        expect(cart.accessory_count('1')).to eq(1)
        expect(cart.accessory_count('2')).to eq(3)
      end
    end

    describe 'add_accesory' do
      it 'should add an accesory id to the cart' do
        cart = Cart.new
        accessory = Accessory.create!(title: 'Accessory 1', price: 1, description: 'This is accessory one', image_url: 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260')

        cart.add_accessory(accessory.id.to_s)

        expect(cart.total_count).to eq(1)
      end
    end

    describe 'remove_accessory' do
      it 'should remove a given accessory' do 
        cart = Cart.new('contents' => {'1' => 1, '2' => 3})

        cart.remove_accessory('1')
        expect(cart.contents).to_not include('1')
      end
    end
    describe 'subtotal' do
      it 'should return the subtotal of a certain accessory' do
        cart = Cart.new
        accessory = Accessory.create!(title: 'Accessory 1', price: 12, description: 'This is accessory one', image_url: 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260')

        cart.add_accessory(accessory.id.to_s)

        expect(cart.subtotal(accessory)).to eq(12)
      end
    end

    describe 'total_amount' do
      it 'should return the total cost of the cart' do
        cart = Cart.new
        accessory = Accessory.create!(title: 'Accessory 1', price: 12, description: 'This is accessory one', image_url: 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260')
        accessory2 = Accessory.create!(title: 'Accessory 2', price: 10, description: 'This is accessory one', image_url: 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260')

        cart.add_accessory(accessory.id.to_s)
        cart.add_accessory(accessory2.id.to_s)

        expect(cart.total_amount).to eq(22)
      end
    end
  end
end

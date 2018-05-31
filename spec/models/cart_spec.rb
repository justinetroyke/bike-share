require 'rails_helper'

RSpec.describe Cart do

  describe "#total_count" do
    it "can calculate the total number of items it holds" do
      cart = Cart.new('contents' => {"1" => 2, "2" => 3})

      expect(cart.total_count).to eq(5)
    end

    it 'item_count' do
      cart = Cart.new('contents' => {'1' => 1, '2' => 3})

      expect(cart.accessory_count('1')).to eq(1)
      expect(cart.accessory_count('2')).to eq(3)
    end

    describe 'adds item to cart' do
      it 'add_item' do
        cart = Cart.new
        item = Item.create!(title: 'Accessory 1', price: 1, description: 'This is accessory one', image_url: 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260')

        cart.add_item(item.id.to_s)

        expect(cart.total_count).to eq(1)
      end
    end
  end
end

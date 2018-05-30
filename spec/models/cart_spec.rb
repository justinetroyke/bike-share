require 'rails_helper'

RSpec.describe Cart do

  describe "#total_count" do
    it "can calculate the total number of items it holds" do
      cart = Cart.new({"1" => 2, "2" => 3})

      expect(cart.total_count).to eq(5)
    end

    # it 'add_movie' do
    #   cart = Cart.new(nil)
    #   id_string = item.id.to_s
    #
    #   expect(cart.contents[id_string]).to eq(0)
    #   cart.add_item(item)
    #
    #   expect(cart.contents[id_string]).to eq(1)
    # end

    it 'item_count' do
      cart = Cart.new({'1' => 1, '2' => 3})

      expect(cart.accessory_count('1')).to eq(1)
      expect(cart.accessory_count('2')).to eq(3)
    end
  end
end

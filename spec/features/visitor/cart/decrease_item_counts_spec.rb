require 'rails_helper'

RSpec.feature "DecreaseItemCounts", type: :feature do
  describe 'A Visitor' do
    context 'visiting /cart' do
      before(:each) do
        @accessory2 = Accessory.create!(title: 'another item', price: 2, description: 'for doin things with bikes')
        visit accessory_path(@accessory2)
        click_link 'Add to Cart'
        visit accessory_path(@accessory2)
        click_link 'Add to Cart'
      end
      it 'should have a button next to each item to descrease the quantity of that item' do
        visit '/cart'
        within("#cart-accessory-#{@accessory2.id}") do
          expect(page).to have_button('Decrease')
          click_on('Decrease')
        end
        expect(page).to have_content(1)
      end
      it 'should have a button next to each item to increase the quantity of that item' do
        visit '/cart'

        within("#cart-accessory-#{@accessory2.id}") do
          expect(page).to have_button('Increase')
          click_on('Increase')
        end
        expect(page).to have_content('2')
      end
    end
  end
end

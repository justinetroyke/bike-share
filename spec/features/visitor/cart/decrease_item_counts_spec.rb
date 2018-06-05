require 'rails_helper'

RSpec.feature "DecreaseItemCounts", type: :feature do
  describe 'A Visitor' do
    context 'visiting /cart' do
      before(:each) do
        @accessory2 = Accessory.create!(title: 'another item', price: 2, description: 'for doin things with bikes')
        visit accessory_path(@accessory2)
        click_button 'Add to Cart'
        visit accessory_path(@accessory2)
        click_button 'Add to Cart'
      end
      it 'should have a button next to each item to descrease the quantity of that item' do
        visit '/cart'
        within("#cart-accessory-#{@accessory2.id}") do
          expect(page).to have_css('#decrease-button')
          click_button('decrease-button')
        end
        visit '/cart'
        expect(page).to have_content('1')
      end
      it 'should have a button next to each item to increase the quantity of that item' do
        visit '/cart'

        within("#cart-accessory-#{@accessory2.id}") do
          expect(page).to have_css('#increase-button')
          click_button('increase-button')
        end
        visit '/cart'
        expect(page).to have_content('3')
      end
    end
  end
end

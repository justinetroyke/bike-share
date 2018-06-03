require 'rails_helper'

RSpec.feature "DecreaseItemCounts", type: :feature do
  describe 'A Visitor' do
    context 'visiting /cart' do
      before(:each) do
        @accessory1 = Accessory.create!(title: 'Cloak', price: 1, description: 'What for not being seen')
        @accessory2 = Accessory.create!(title: 'Dagger', price: 2, description: 'What for the stabby stabby')
        visit accessory_path(@accessory2)
        click_link 'Add to Cart'
        visit accessory_path(@accessory2)
        click_link 'Add to Cart'
        visit accessory_path(@accessory1)
        click_link 'Add to Cart'
      end
      it 'should have a button next to each item to descrease the quantity of that item' do
        within("#cart-accessory-#{@accessory2.id}") do
          expect(page).to have_button('Decrease')
          click_on('Decrease')
          expect(page).to have_content('1')
        end
      end
      it 'should have a button next to each item to increase the quantity of that item' do
        within("#cart-accessory-#{@accessory1.id}") do
          expect(page).to have_button('Increase')
          click_on('Increase')
          expect(page).to have_content('2')
        end
      end
    end
  end
end

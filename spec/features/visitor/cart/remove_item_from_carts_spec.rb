require 'rails_helper'

RSpec.feature "RemoveItemFromCarts", type: :feature do
  describe 'A Visitor' do
    context 'visiting the cart path' do
      before (:each) do 
        @accessory1 = Accessory.create!(title: 'Cloak', price: 1, description: 'What for not being seen')
        @accessory2 = Accessory.create!(title: 'Dagger', price: 2, description: 'What for the stabby stabby')
        visit accessory_path(@accessory2)
        click_link 'Add to Cart'
        visit accessory_path(@accessory2)
        click_link 'Add to Cart'
        visit accessory_path(@accessory1)
        click_link 'Add to Cart'

        visit '/cart'
      end
      it 'should have a remove item button next to each item' do
        within("#cart-accessory-#{@accessory1.id}") do
          expect(page).to have_button('Remove')
        end
      end
      it 'should remove the item and return the visitor to the cart page' do
        within("#cart-accessory-#{@accessory1.id}") do
          click_on('Remove')
        end
        expect(current_path).to eq('/cart')
        within('table') do
          expect(page).to_not have_content(@accessory1.title)
        end
      end
      context 'flash message' do
        it 'should display a flash message upon deletion' do
          within("#cart-accessory-#{@accessory1.id}") do
            click_on('Remove')
          end

          expect(page).to have_content("Successfully removed #{@accessory1.title} from your cart.")
        end
        it 'should contain a link back to the deleted accesorys page' do
          within("#cart-accessory-#{@accessory1.id}") do
            click_on('Remove')
          end

          within('.link') do
            expect(page).to have_link("#{@accessory1.title}")
          end
        end
      end
    end
  end
end

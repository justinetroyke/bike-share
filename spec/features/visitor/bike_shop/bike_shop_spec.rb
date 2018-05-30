require 'rails_helper'

RSpec.describe 'Bike Shop Page' do
  before :each do
    n = 0
    @items = []
    24.times do
      n += 1
      @items << Item.create!(title: "Item #{n}", price: "#{n}.00".to_f, image: "default/item#{n}.png", description: "This is the description for item#{n}")
    end
  end

  context '/bike-shop' do
    describe 'A visitor visits the bike shop page' do
      it 'they should see at least 12 bike accessories (items) for sale' do
        visit '/bike-shop'

        i = 0
        @items.length.times do
          expect(page).to have_content(@items[i].title)
          expect(page).to have_content(@items[i].price)
          expect(page).to have_content(@items[i].description)
          i += 1
        end
      end

      it 'there should be Add to Cart buttons for each item' do
        visit '/bike-shop'

        i = 0
        @items.length.times do
          within("#item-#{@items[i].id}") do
            expect(page).to have_link('Add to Cart')
          end
          i += 1
        end
      end
    end

    describe 'A visitor clicks the \'Add to Cart\' button for an item' do
      it 'should display a flash message saying that the item has been added to the cart' do
        visit '/bike-shop'

        within("#item-#{@items[0].id}") do
          click_link 'Add to Cart'
        end
        expect(page).to have_content("#{@items[0].title} has been add to your cart!")

        within("#item-#{@items[11].id}") do
          click_link 'Add to Cart'
        end
        expect(page).to have_content("#{@items[11].title} has been add to your cart!")

        within("#item-#{@items[23].id}") do
          click_link 'Add to Cart'
        end
        expect(page).to have_content("#{@items[23].title} has been add to your cart!")
      end

      it 'the cart count should update on all pages' do
        visit '/bike-shop'

        within("#item-#{@items[0].id}") do
          click_link 'Add to Cart'
        end

        within('#top_bar') do
          expect(page).to have_content('1')
        end

        #Need some more pages to test
      end
    end
  end
end

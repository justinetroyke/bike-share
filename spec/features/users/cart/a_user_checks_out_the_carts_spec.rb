require 'rails_helper'

RSpec.feature "A User Checks Out The Cart", type: :feature do
  describe 'A User' do
    context 'On the cart page' do
      context 'After clicking on checkout' do
        it 'should create a new order for that user, with those items' do
          @accessory1 = Accessory.create!(title: 'Accessory 1', price: 12, description: 'This is accessory 1')
          @accessory2 = Accessory.create!(title: 'Accessory 2', price: 12, description: 'This is accessory 2')
          @accessory3 = Accessory.create!(title: 'Accessory 3', price: 12, description: 'This is accessory 3')
          @accessory4 = Accessory.create!(title: 'Accessory 4', price: 12, description: 'This is accessory 4')

          @user = User.create!(username:'admin', password: 'password',first_name:'my', last_name:'name', address:'asdf', role:1)
          visit accessories_path

          within("#accessory-#{@accessory1.id}") do
            click_on 'Add to Cart'
          end
          within("#accessory-#{@accessory2.id}") do
            click_on 'Add to Cart'
          end
          within("#accessory-#{@accessory3.id}") do
            click_on 'Add to Cart'
          end
          within("#accessory-#{@accessory4.id}") do
            click_on 'Add to Cart'
          end

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

          visit '/cart'

          expect(page).to have_content(@accessory1.title)
          expect(page).to have_content(@accessory2.title)
          expect(page).to have_content(@accessory3.title)
          expect(page).to have_content(@accessory4.title)

          click_on 'Checkout'
          @order = Order.find_by(user: @user)
          expect(current_path).to eq(dashboard_path)
          expect(page).to have_content("My Orders:")
          expect(page).to have_link(@order.id)
        end
      end
    end
  end
end

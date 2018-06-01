require 'rails_helper'

RSpec.feature 'admin dashboard' do
  describe 'An Admin' do
    context 'visiting the admin dashboard' do
      before(:each) do
        @image_url = 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
        @user1 = User.create!(role: 0, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
        @order1 = @user1.orders.create!(status:0)
        @accessory1 = @order1.accessories.create!(title: 'Item 1', price: 1, description: 'This is item 1', image_url: @image_url)

        @user2 = User.create!(role: 0, username: 'user2', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
        @order2 = @user2.orders.create!(status:1)
        @order2.accessories.create!(title: 'Item 2', price: 1, description: 'This is item 1', image_url: @image_url)

        @user2 = User.create!(role: 0, username: 'user3', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
        @order4 = @user2.orders.create!(status:1)
        @order4.accessories.create!(title: 'Item 5', price: 1, description: 'This is item 1', image_url: @image_url)

        @user3 = User.create!(role: 0, username: 'user4', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
        @order3 = @user3.orders.create!(status:2)
        @order3.accessories.create!(title: 'Item 3', price: 1, description: 'This is item 1', image_url: @image_url)

        @user4 = User.create!(role: 0, username: 'user5', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
        @order4 = @user4.orders.create!(status:3)
        @order4.accessories.create!(title: 'Item 4', price: 1, description: 'This is item 1', image_url: @image_url)
        @admin = User.create(username:'VB',
                            first_name:'Charles',
                            last_name:'Coughlin',
                            address:'wherever',
                            password:'buster',
                            role:1)
      end
      it 'should display all orders with each order being a link' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

        visit admin_dashboard_path
        
        
        Order.all.each do |order|
          within("#order-#{order.id}") do
            expect(page).to have_link(order.id)
            expect(page).to have_content(order.quantity)
          end
        end
      end
      it 'should show the total orders for each status' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

        visit admin_dashboard_path

        expect(page).to have_content("Cancelled: 1")
        expect(page).to have_content("Ordered: 2")
        expect(page).to have_content("Paid: 1")
        expect(page).to have_content("Completed: 1")
      end
      it 'should have links to show orders in each category' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

        visit admin_dashboard_path

        expect(page).to have_link('Cancelled')
        expect(page).to have_link('Ordered')
        expect(page).to have_link('Paid')
        expect(page).to have_link('Completed')
      end
      it 'should have buttons to cancel orders which are paid or ordered' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

        visit admin_dashboard_path
        click_on('Paid')

        within("#paid-#{@order3.id}") do
          expect(page).to have_button('Cancel')
        end

        click_on('Ordered')

        within("#ordered-#{@order2.id}") do
          expect(page).to have_button('Cancel')
        end

      end
      it 'should have a button to mark as paid for orders which are ordered' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

        visit admin_dashboard_path
        click_on('Ordered')

        within("#ordered-#{@order2.id}") do
          expect(page).to have_button('Mark as Paid')
        end
      end
      it 'should have a button to mark as completed for orders whcih are paid' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

        visit admin_dashboard_path
        click_on('Paid')

        within("#paid-#{@order3.id}") do
          expect(page).to have_button('Mark as Paid')
        end
      end
    end
  end
end

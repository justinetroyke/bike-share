require 'rails_helper'

RSpec.feature "VisitorTriesToSeeOrders", type: :feature do
  describe 'A visitor' do
    context 'trying to visit and order path that isnt theirs' do
      it 'should render a 403 page' do
        @image_url = 'https://images.pexels.com/photos/686230/pexels-photo-686230.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
        @user1 = User.create!(role: 0, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
        @order1 = @user1.orders.create!(status:0)
        @accessory1 = @order1.accessories.create!(title: 'Item 1', price: 1, description: 'This is item 1', image_url: @image_url)

        @user2 = User.create!(role: 0, username: 'user2', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
        @order2 = @user2.orders.create!(status:1)
        @order2.accessories.create!(title: 'Item 2', price: 1, description: 'This is item 1', image_url: @image_url)

        visit order_path(@order1)
        expect(status_code).to eq(403)
      end
    end
  end
end

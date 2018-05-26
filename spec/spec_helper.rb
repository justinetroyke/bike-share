RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

  config.before :each do
    # Create Users
    @user1 = User.create!(role: 1, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
    @user2 = User.create!(role: 0, username: 'user2', password: 'user2spassword', address: '222 Not An Address', first_name: 'User', last_name: 'Two')
    @user3 = User.create!(role: 0, username: 'user3', password: 'user3spassword', address: '333 Not An Address', first_name: 'User', last_name: 'Three')
    @user4 = User.create!(role: 0, username: 'user4', password: 'user4spassword', address: '444 Not An Address', first_name: 'User', last_name: 'Four')

    # Create Orders
    # User 1 Orders
    @order1 = @user1.orders.create!(status: 'ordered', quantity: 12)
    @order2 = @user1.orders.create!(status: 'completed', quantity: 24)
    @order3 = @user1.orders.create!(status: 'paid', quantity: 48)
    @order4 = @user1.orders.create!(status: 'cancelled', quantity: 72)
    # User 2 Orders
    @order5 = @user2.orders.create!(status: 'completed', quantity: 18)
    @order6 = @user2.orders.create!(status: 'paid', quantity: 2)
    # User 3 Orders
    @order6 = @user3.orders.create!(status: 'ordered', quantity: 23)
    @order7 = @user3.orders.create!(status: 'cancelled', quantity: 47)
    # User 4 will have no orders

    # Create Items (and OrderItems)
    @item1 = @order1.items.create(title: 'Item 1', price: 1.23, image: 'default/image1', description: 'This is Item 1\'s description')
    @item2 = @order1.items.create(title: 'Item 2', price: 2.23, image: 'default/image2', description: 'This is Item 2\'s description')
    # @item3 = @order2.items.create(title: 'Item 2', price: 2.23, image: 'default/image2', description: 'This is Item 2\'s description')
    @item3 = @order2.items.create(title: 'Item 3', price: 3.33, image: 'default/image3', description: 'This is Item 3\'s description')
    @item4 = @order3.items.create(title: 'Item 4', price: 4.44, image: 'default/image4', description: 'This is Item 4\'s description')
    @item5 = @order4.items.create(title: 'Item 5', price: 5.55, image: 'default/image5', description: 'This is Item 5\'s description')
    @item6 = @order5.items.create(title: 'Item 6', price: 6.66, image: 'default/image6', description: 'This is Item 6\'s description')
    @item7 = @order6.items.create(title: 'Item 7', price: 7.77, image: 'default/image7', description: 'This is Item 7\'s description')
    @item8 = @order7.items.create(title: 'Item 8', price: 8.88, image: 'default/image8', description: 'This is Item 8\'s description')

    # Create Stations
    @station1 = Station.create!(name: 'Union Station', dock_count: 12, city: 'Denver', installation_date: Date.now)
    @station1 = Station.create!(name: 'Civic Center', dock_count: 24, city: 'Denver', installation_date: Date.now)
    @station1 = Station.create!(name: 'Denver University', dock_count: 36, city: 'Denver', installation_date: Date.now)

    # Create Trips
    # This trip has no end_station or end_date
    @trip1 = @station1.trips.create!(duration: 23, start_date: Date.now)
    @trip2 = @station2.trips.create!(duration: 46, start_date: Date.now, end_date: Date.now, end_station_id: @station2.id)
    @trip3 = @station3.trips.create!(duration: 72, start_date: Date.now, end_date: Date.now, end_station_id: @station1.id)
  end
end

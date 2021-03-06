RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation  # clean DB of any leftover data
    DatabaseCleaner.strategy = :transaction # rollback transactions between each test
    Rails.application.load_seed # (optional) seed DB
  end
  
  config.before(:each) do
    DatabaseCleaner.start
  end
  
  config.after(:each) do
    DatabaseCleaner.clean
  end
  # config.before :each do
    # # Create Users
    # @spec_user1 = User.create!(role: 1, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
    # @spec_user2 = User.create!(role: 0, username: 'user2', password: 'user2spassword', address: '222 Not An Address', first_name: 'User', last_name: 'Two')
    # @spec_user3 = User.create!(role: 0, username: 'user3', password: 'user3spassword', address: '333 Not An Address', first_name: 'User', last_name: 'Three')
    # @spec_user4 = User.create!(role: 0, username: 'user4', password: 'user4spassword', address: '444 Not An Address', first_name: 'User', last_name: 'Four')

    # # Create Orders
    # # User 1 Orders
    # @spec_order1 = @spec_user1.orders.create!(status: 'ordered', quantity: 12)
    # @spec_order2 = @spec_user1.orders.create!(status: 'completed', quantity: 24)
    # @spec_order3 = @spec_user1.orders.create!(status: 'paid', quantity: 48)
    # @spec_order4 = @spec_user1.orders.create!(status: 'cancelled', quantity: 72)
    # # User 2 Orders
    # @spec_order5 = @spec_user2.orders.create!(status: 'completed', quantity: 18)
    # @spec_order6 = @spec_user2.orders.create!(status: 'paid', quantity: 2)
    # # User 3 Orders
    # @spec_order6 = @spec_user3.orders.create!(status: 'ordered', quantity: 23)
    # @spec_order7 = @spec_user3.orders.create!(status: 'cancelled', quantity: 47)
    # # User 4 will have no orders

    # # Create Items (and OrderItems)
    # @spec_item1 = @spec_order1.items.create(title: 'Item 1', price: 1.23, image: 'default/image1', description: 'This is Item 1\'s description')
    # @spec_item2 = @spec_order1.items.create(title: 'Item 2', price: 2.23, image: 'default/image2', description: 'This is Item 2\'s description')
    # # @item3 = @spec_order2.items.create(title: 'Item 2', price: 2.23, image: 'default/image2', description: 'This is Item 2\'s description')
    # @spec_item3 = @spec_order2.items.create(title: 'Item 3', price: 3.33, image: 'default/image3', description: 'This is Item 3\'s description')
    # @spec_item4 = @spec_order3.items.create(title: 'Item 4', price: 4.44, image: 'default/image4', description: 'This is Item 4\'s description')
    # @spec_item5 = @spec_order4.items.create(title: 'Item 5', price: 5.55, image: 'default/image5', description: 'This is Item 5\'s description')
    # @spec_item6 = @spec_order5.items.create(title: 'Item 6', price: 6.66, image: 'default/image6', description: 'This is Item 6\'s description')
    # @spec_item7 = @spec_order6.items.create(title: 'Item 7', price: 7.77, image: 'default/image7', description: 'This is Item 7\'s description')
    # @spec_item8 = @spec_order7.items.create(title: 'Item 8', price: 8.88, image: 'default/image8', description: 'This is Item 8\'s description')

    # # Create Stations
    # @spec_station1 = Station.create!(name: 'Union Station', dock_count: 12, city: 'Denver', installation_date: DateTime.now)
    # @spec_station2 = Station.create!(name: 'Civic Center', dock_count: 24, city: 'Denver', installation_date: DateTime.now)
    # @spec_station3 = Station.create!(name: 'Denver University', dock_count: 36, city: 'Denver', installation_date: DateTime.now)

    # # Create Trips
    # # This trip has no end_station or end_date
    # @spec_trip1 = @spec_station1.start_trips.create!(duration: 23, start_date: DateTime.now, end_date: DateTime.now, end_station_id: @spec_station3.id, bike_id: 1, subscription_type: 'annual', zip_code: 00000)
    # @spec_trip2 = @spec_station2.start_trips.create!(duration: 46, start_date: DateTime.now, end_date: DateTime.now, end_station_id: @spec_station2.id, bike_id: 2, subscription_type: 'monthly', zip_code: 00000)
    # @spec_trip3 = @spec_station3.start_trips.create!(duration: 72, start_date: DateTime.now, end_date: DateTime.now, end_station_id: @spec_station1.id, bike_id: 3, subscription_type: 'annual', zip_code: 00000)
  # end
end

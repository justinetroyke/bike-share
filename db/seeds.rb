# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@spec_user1 = User.create!(role: 1, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
@spec_user2 = User.create!(role: 0, username: 'user2', password: 'user2spassword', address: '222 Not An Address', first_name: 'User', last_name: 'Two')
@spec_user3 = User.create!(role: 0, username: 'user3', password: 'user3spassword', address: '333 Not An Address', first_name: 'User', last_name: 'Three')
@spec_user4 = User.create!(role: 0, username: 'user4', password: 'user4spassword', address: '444 Not An Address', first_name: 'User', last_name: 'Four')
# Create Orders
# User 1 Orders
@spec_order1 = @spec_user1.orders.create!(status: 'ordered')
@spec_order2 = @spec_user1.orders.create!(status: 'completed')
@spec_order3 = @spec_user1.orders.create!(status: 'paid')
@spec_order4 = @spec_user1.orders.create!(status: 'cancelled')
# User 2 Orders
@spec_order5 = @spec_user2.orders.create!(status: 'completed')
@spec_order6 = @spec_user2.orders.create!(status: 'paid')
# User 3 Orders
@spec_order6 = @spec_user3.orders.create!(status: 'ordered')
@spec_order7 = @spec_user3.orders.create!(status: 'cancelled')
# User 4 will have no order
# Create Items (and OrderItems)
@spec_item1 = @spec_order1.items.create(title: 'Item 1', price: 1.23, image: 'default/image1', description: 'This is Item 1\'s description')
@spec_item2 = @spec_order1.items.create(title: 'Item 2', price: 2.23, image: 'default/image2', description: 'This is Item 2\'s description')
# @item3 = @spec_order2.items.create(title: 'Item 2', price: 2.23, image: 'default/image2', description: 'This is Item 2\'s description')
@spec_item3 = @spec_order2.items.create(title: 'Item 3', price: 3.33, image: 'default/image3', description: 'This is Item 3\'s description')
@spec_item4 = @spec_order3.items.create(title: 'Item 4', price: 4.44, image: 'default/image4', description: 'This is Item 4\'s description')
@spec_item5 = @spec_order4.items.create(title: 'Item 5', price: 5.55, image: 'default/image5', description: 'This is Item 5\'s description')
@spec_item6 = @spec_order5.items.create(title: 'Item 6', price: 6.66, image: 'default/image6', description: 'This is Item 6\'s description')
@spec_item7 = @spec_order6.items.create(title: 'Item 7', price: 7.77, image: 'default/image7', description: 'This is Item 7\'s description')
@spec_item8 = @spec_order7.items.create(title: 'Item 8', price: 8.88, image: 'default/image8', description: 'This is Item 8\'s description')
# Create Stations
@spec_station1 = Station.create!(name: 'Union Station', dock_count: 12, city: 'Denver', installation_date: DateTime.now)
@spec_station2 = Station.create!(name: 'Civic Center', dock_count: 24, city: 'Denver', installation_date: DateTime.now)
@spec_station3 = Station.create!(name: 'Denver University', dock_count: 36, city: 'Denver', installation_date: DateTime.now)
# Create Trips
# This trip has no end_station or end_date
@spec_trip1 = @spec_station1.start_trips.create!(duration: 23, start_date: DateTime.now, end_date: DateTime.now, end_station_id: @spec_station3.id, bike_id: 1, subscription_type: 'annual', zip_code: 00000)
@spec_trip2 = @spec_station2.start_trips.create!(duration: 46, start_date: DateTime.now, end_date: DateTime.now, end_station_id: @spec_station2.id, bike_id: 2, subscription_type: 'monthly', zip_code: 00000)
@spec_trip3 = @spec_station3.start_trips.create!(duration: 72, start_date: DateTime.now, end_date: DateTime.now, end_station_id: @spec_station1.id, bike_id: 3, subscription_type: 'annual', zip_code: 00000)

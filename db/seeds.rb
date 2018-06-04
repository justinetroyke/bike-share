require 'csv'

if Rails.env == 'development' || Rails.env == 'production'
  stations_data = CSV.read('db/csv/stations.csv', headers: true, header_converters: :symbol)
  trips_data = CSV.read('db/csv/trips.csv', headers: true, header_converters: :symbol)
  orders_data = CSV.read('db/csv/orders.csv', headers: true, header_converters: :symbol)
  mock_users_data = CSV.read('db/csv/users.csv', headers: true, header_converters: :symbol)
  accessories_data = CSV.read('db/csv/accessories.csv', headers: true, header_converters: :symbol)
  order_accessories_data = CSV.read('db/csv/order_accessories.csv', headers: true, header_converters: :symbol)


  stations_data.each do |row|
    Station.find_or_create_by!(name: row[:name], dock_count: row[:dock_count], city: row[:city], installation_date: row[:installation_date])
  end

  trips_data.each do |row|
    Trip.find_or_create_by!(duration: row[:duration], start_date: row[:start_date], end_date: row[:end_date], subscription_type: row[:subscription_type], zip_code: row[:zip_code], start_station_id: row[:start_station_id], end_station_id: row[:end_station_id], bike_id: row[:bike_id])
  end

  mock_users_data.each do |row|
    User.find_or_create_by!(username: row[:username], password_digest: row[:password], address: row[:address], first_name: row[:first_name], last_name: row[:last_name])
  end

  orders_data.each do |row|
    Order.find_or_create_by!(user_id: row[:user_id], status: row[:status])
  end

  accessories_data.each do |row|
    Accessory.find_or_create_by!(title: row[:title], price: row[:price], description: row[:description], status: row[:status])
  end

  order_accessories_data.each do |row|
    OrderAccessory.find_or_create_by!(order_id: row[:order_id], accessory_id: row[:accessory_id])
  end
end

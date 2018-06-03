require 'csv'

stations_data = CSV.read('db/csv/stations.csv', headers: true, header_converters: :symbol)
trips_data = CSV.read('db/csv/trips.csv', headers: true, header_converters: :symbol)


stations_data.each do |row|
  Station.create!(name: row[:name], dock_count: row[:dock_count], city: row[:city], installation_date: row[:installation_date])
end

trips_data.each do |row|
  Trip.create!(duration: row[:duration], start_date: row[:start_date], end_date: row[:end_date], subscription_type: row[:subscription_type], zip_code: row[:zip_code], start_station_id: row[:start_station_id], end_station_id: row[:end_station_id], bike_id: row[:bike_id])
end
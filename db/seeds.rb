require 'csv'

stations_data = CSV.read('db/csv/stations.csv', headers: true, header_converters: :symbol)
trips_data = CSV.read('db/csv/trips.csv', headers: true, header_converters: :symbol)


stations_data.each do |row|
  Station.create!(name: row[:name], dock_count: row[:dock_count], city: row[:city], installation_date: row[:installation_date])
end
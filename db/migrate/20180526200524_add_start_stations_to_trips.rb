class AddStartStationsToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :start_station_id, :integer
    add_foreign_key :trips, :stations, column: :start_station_id, primary_key: :id
  end
end

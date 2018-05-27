class RemoveStartStationIdsAndEndStattionIdsFromTrips < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips, :start_station_id
    remove_column :trips, :end_station_id
  end
end

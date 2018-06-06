class Trip < ApplicationRecord
  validates_presence_of :duration,
                        :start_date,
                        :start_station_id,
                        :end_station_id,
                        :bike_id,
                        :subscription_type
  validates_inclusion_of :subscription_type, in: ['subscriber', 'customer']

  # enum subscription_type: [:subscriber, :customer]
                        
  belongs_to :start_station, class_name: 'Station'
  belongs_to :end_station, class_name: 'Station'
end

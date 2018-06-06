class Trip < ApplicationRecord
  validates_presence_of :duration,
                        :start_date,
                        :start_station_id,
                        :end_station_id,
                        :bike_id,
                        :subscription_type

  belongs_to :start_station, class_name: 'Station'
  belongs_to :end_station, class_name: 'Station'

  def self.average_duration
    average(:duration).to_f
  end

  def self.longest
    find_by(duration: maximum(:duration))
  end

  def self.shortest
    find_by(duration: minimum(:duration))
  end

  def self.station_most_started
    most_started = select('start_station_id, count(start_station_id) as trips')
                        .group('start_station_id')
                        .order('trips DESC')
                        .limit(1)

    Station.find(most_started.first.start_station_id)
  end
end

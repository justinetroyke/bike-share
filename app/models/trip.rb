class Trip < ApplicationRecord
  validates_presence_of :duration,
                        :start_date,
                        :start_station_id,
                        :end_station_id,
                        :bike_id,
                        :subscription_type
                        
  validates_inclusion_of :subscription_type, in: ['subscriber', 'customer']
                        
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

  def self.station_most_ended
    most_ended = select('start_station_id, count(start_station_id) as trips')
                        .group('start_station_id')
                        .order('trips DESC')
                        .limit(1)

    Station.find(most_ended.last.start_station_id)
  end

  def self.monthly_trips
    select("DATE_TRUNC('month', start_date) as month, count(*) as count")
    .group('month')
    .order('month')
  end

  def self.yearly_trips
    select("DATE_TRUNC('year', start_date) as year, count(*) as count")
    .group('year')
    .order('year')
  end

  def self.most_used_bike
    bike_and_total = group(:bike_id).count.max_by { |bike, total| total }
    { bike: bike_and_total[0], total: bike_and_total[1] }
  end
end

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
    group("DATE_TRUNC('month', start_date)").count

  end

  def self.yearly_trips
    monthly_trips.each_with_object({}) do |(month, count), obj|
      unless obj[month.year]
        obj[month.year] = {"January" => 0, "February" => 0, "March" => 0, "April" => 0, "May" => 0, "June" => 0, "July" => 0, "August" => 0, "September" => 0, "October" => 0, "November" => 0, "December" => 0}
      end
      obj[month.year][month.strftime('%B')] = count
    end
  end

  def self.most_used_bike
    bike_and_total = group(:bike_id).count.max_by { |bike, total| total }
    { bike: bike_and_total[0], total: bike_and_total[1] }
  end

  def self.least_used_bike
    bike_and_total = group(:bike_id).count.min_by { |bike, total| total }
    { bike: bike_and_total[0], total: bike_and_total[1] }
  end

  def self.subscription_breakdown
    subs = group(:subscription_type).count
    total = subs.values.sum
    {
      "customer" => {"count" => subs['customer'], "percentage" => subs['customer'] / total.to_f * 100},
      "subscriber" => {"count" => subs['subscriber'], "percentage" => subs['subscriber'] / total.to_f * 100}
    }
  end

  def self.date_with_most_trips
    date_and_count = group("date_trunc('day',start_date)").count.max_by { |date, trips_count| trips_count }
    {
      date: date_and_count[0].strftime('%m/%d/%Y'),
      trips_count: date_and_count[1]
    }
  end

  def self.date_with_least_trips
    date_and_count = group("date_trunc('day',start_date)").count.min_by { |date, trips_count| trips_count }
    {
      date: date_and_count[0].strftime('%m/%d/%Y'),
      trips_count: date_and_count[1]
    }
  end
end

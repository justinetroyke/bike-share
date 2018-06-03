class Station < ApplicationRecord
  validates_presence_of :name,
                        :dock_count,
                        :city,
                        :installation_date

  has_many :start_trips, class_name: 'Trip', foreign_key: 'start_station_id'
  has_many :end_trips, class_name: 'Trip', foreign_key: 'end_station_id'

  before_save :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end

  def most_frequent_destination
    start_trips.group(:end_station)
               .order('count_id desc')
               .count('id').keys.first

  end

  def most_frequent_origination
    end_trips.group(:start_station).order('count_id asc').count('id').keys.first
  end

  def busiest_date
    trips = start_trips + end_trips
    trips.group_by{|i| i.created_at.to_date}
    .max_by{|date,stations| stations.count}.first
  end

  def most_frequent_zip_code
    (start_trips + end_trips).group_by{|i| i.zip_code}
    .max_by{|zip,stations| stations.count}.first
  end

  def favorite_bike
  end
end

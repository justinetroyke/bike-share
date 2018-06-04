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
    start_trips.group(:end_station).order('count_id desc').count('id').keys.first
  end

  def most_frequent_origination
    end_trips.group(:start_station).order('count_id asc').count('id').keys.first
  end

  def busiest_date
    unless start_trips.empty? && end_trips.empty?
      (start_trips + end_trips).group_by{|i| i.created_at.to_date}
      .max_by{|date,stations| stations.count}.first
    end
  end

  def most_frequent_zip_code
    unless start_trips.empty? && end_trips.empty?
      (start_trips + end_trips).group_by{|i| i.zip_code}
      .max_by{|zip,stations| stations.count}.first
    end
  end

  def favorite_bike
    unless start_trips.empty? && end_trips.empty?
      (start_trips + end_trips).group_by{|i| i.bike_id}
      .max_by{|bike,stations| stations.count}.first
    end
  end
  
  def self.average_bikes_per_station
    average(:dock_count).round(2)
  end

  def self.most_bikes_available
    maximum(:dock_count)
  end

  def self.most_bikes
    maximum(:dock_count)
  end

  def self.stations_with_most_bikes
    where(dock_count: most_bikes)
  end

  def self.least_bikes
    minimum(:dock_count)
  end

  def self.stations_with_least_bikes
    where(dock_count: least_bikes)
  end
end

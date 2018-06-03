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

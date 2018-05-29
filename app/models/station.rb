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
end

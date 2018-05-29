class AddSlugToStations < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :slug, :string
  end
end

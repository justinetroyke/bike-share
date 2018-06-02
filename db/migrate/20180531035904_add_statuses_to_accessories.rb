class AddStatusesToAccessories < ActiveRecord::Migration[5.2]
  def change
    add_column :accessories, :status, :integer, default: 0
  end
end

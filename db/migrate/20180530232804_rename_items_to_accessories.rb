class RenameItemsToAccessories < ActiveRecord::Migration[5.2]
  def change
    rename_table :items, :accessories
  end
end

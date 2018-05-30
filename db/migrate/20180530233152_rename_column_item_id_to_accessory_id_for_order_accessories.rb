class RenameColumnItemIdToAccessoryIdForOrderAccessories < ActiveRecord::Migration[5.2]
  def change
    rename_column :order_accessories, :item_id, :accessory_id
  end
end

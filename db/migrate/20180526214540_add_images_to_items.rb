class AddImagesToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :image, :string, default: 'image1'
  end
end

class AddImagesToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :image, :string, default: 'default/image1'
  end
end

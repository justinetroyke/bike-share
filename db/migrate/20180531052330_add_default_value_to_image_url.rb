class AddDefaultValueToImageUrl < ActiveRecord::Migration[5.2]
  def change
    change_column :accessories, :image_url, :string, default: "https://pics.me.me/bike-repair-cant-call-see-the-problaym-heer-memes-com-13867434.png"
  end
end

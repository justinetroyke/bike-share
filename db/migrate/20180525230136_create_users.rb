class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :role, default: 0
      t.string :username
      t.string :password_digest
      t.string :address
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end

class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.references :worker, foreign_key: true
      t.integer :prefecture
      t.string :city
      t.string :place

      t.timestamps
    end
  end
end

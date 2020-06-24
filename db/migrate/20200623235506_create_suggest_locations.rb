class CreateSuggestLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :suggest_locations do |t|
      t.references :suggest, foreign_key: true
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end

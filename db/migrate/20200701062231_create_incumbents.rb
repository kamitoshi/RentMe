class CreateIncumbents < ActiveRecord::Migration[5.2]
  def change
    create_table :incumbents do |t|
      t.references :worker, foreign_key: true
      t.string :store_name, null: false
      t.string :description
      t.boolean :is_active, default: false

      t.timestamps
    end
  end
end

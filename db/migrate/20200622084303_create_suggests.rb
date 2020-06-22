class CreateSuggests < ActiveRecord::Migration[5.2]
  def change
    create_table :suggests do |t|
      t.references :worker, foreign_key: true
      t.string :title, null: false
      t.text :detail, null: false
      t.string :price, null: false
      t.date :target_date, null: false
      t.time :opening, null: false
      t.time :closing, null: false
      t.boolean :is_active, default: true

      t.timestamps
    end
    add_index :suggests, :title
    add_index :suggests, :target_date
    add_index :suggests, :opening
    add_index :suggests, :closing
  end
end

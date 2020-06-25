class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.references :suggest, foreign_key: true
      t.references :employer, foreign_key: true
      t.integer :price, null: false
      t.time :opening, null: false
      t.time :closing, null: false
      t.text :content
      t.boolean :is_apply, default: true
      t.boolean :is_approval

      t.timestamps
    end
    add_index :offers, [:suggest_id, :employer_id], unique: true
  end
end

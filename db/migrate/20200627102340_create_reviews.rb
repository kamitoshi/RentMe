class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :worker, foreign_key: true
      t.references :employer, foreign_key: true
      t.references :contract, foreign_key: true
      t.integer :service_rate, null: false
      t.integer :skill_rate, null: false
      t.integer :voice_rate, null: false
      t.integer :earnest_rate, null: false
      t.integer :smile_rate, null: false
      t.text :detail

      t.timestamps
    end
  end
end

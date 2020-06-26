class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.references :worker, foreign_key: true
      t.references :employer, foreign_key: true
      t.string :job_description, null: false
      t.integer :price, null: false
      t.date :target_date, null: false
      t.time :opening, null: false
      t.time :closing, null: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

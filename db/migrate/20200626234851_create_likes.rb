class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :worker, foreign_key: true
      t.references :employer, foreign_key: true

      t.timestamps
    end

    add_index :likes, [:worker_id, :employer_id], unique: true

  end
end

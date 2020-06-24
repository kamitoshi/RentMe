class CreateHolds < ActiveRecord::Migration[5.2]
  def change
    create_table :holds do |t|
      t.references :suggest, foreign_key: true
      t.references :employer, foreign_key: true

      t.timestamps
    end
    add_index :holds, [:suggest_id, :employer_id], unique: true
  end
end

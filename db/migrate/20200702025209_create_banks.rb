class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.references :worker, foreign_key: true
      t.string :bank_name, null: false
      t.string :store_number, null: false
      t.string :account_number, null:false
      t.boolean :is_default, default: false

      t.timestamps
    end
  end
end

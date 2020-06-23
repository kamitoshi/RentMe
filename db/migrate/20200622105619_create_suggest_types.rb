class CreateSuggestTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :suggest_types do |t|
      t.references :suggest, foreign_key: true
      t.references :type, foreign_key: true

      t.timestamps
    end
  end
end

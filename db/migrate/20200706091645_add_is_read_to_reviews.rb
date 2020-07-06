class AddIsReadToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :is_read, :boolean, default: false
  end
end

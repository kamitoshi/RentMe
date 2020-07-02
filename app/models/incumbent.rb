class Incumbent < ApplicationRecord
  belongs_to :worker

  validates :store_name, presence: true
end

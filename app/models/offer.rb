class Offer < ApplicationRecord
  belongs_to :suggest
  belongs_to :employer

  validates :price, presence: true
  validates :opening, presence: true
  validates :closing, presence: true
end

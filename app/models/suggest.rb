class Suggest < ApplicationRecord
  belongs_to :worker
  has_many :holds
  has_many :offers, dependent: :destroy

  # Typeアソシエーション 
  has_many :suggest_types, dependent: :destroy
  has_many :types, through: :suggest_types

  # Locationアソシエーション 
  has_many :suggest_locations, dependent: :destroy
  has_many :locations, through: :suggest_locations

  validates :title, presence: true
  validates :detail, length:{maximum:500}
  validates :price, presence: true
  validates :target_date, presence: true
  validates :opening, presence: true
  validates :closing, presence: true
end

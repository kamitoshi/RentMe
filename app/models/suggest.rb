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

end

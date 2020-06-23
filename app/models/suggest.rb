class Suggest < ApplicationRecord
  belongs_to :worker

  has_many :suggest_types
  has_many :types, through: :suggest_types
end

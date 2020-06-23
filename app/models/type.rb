class Type < ApplicationRecord
  has_many :suggest_types
  has_many :suggests, through: :suggest_types
end

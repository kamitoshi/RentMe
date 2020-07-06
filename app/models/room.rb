class Room < ApplicationRecord
  belongs_to :worker
  belongs_to :employer

  has_many :messages, dependent: :destroy
end

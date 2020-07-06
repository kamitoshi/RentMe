class Room < ApplicationRecord
  belongs_to :worker
  belongs_to :employer
end

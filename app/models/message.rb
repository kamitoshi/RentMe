class Message < ApplicationRecord
  belongs_to :room

  enum user:{worker: 0, employer: 1}
  
  validates :content, presence: true
end

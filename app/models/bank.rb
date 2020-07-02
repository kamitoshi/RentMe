class Bank < ApplicationRecord
  belongs_to :worker

  validates :bank_name, presence: true
  validates :store_number, presence: true
  validates :account_number, presence: true
end

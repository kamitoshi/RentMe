class Review < ApplicationRecord
  belongs_to :worker
  belongs_to :employer
  belongs_to :contract

  validates :service_rate, presence: true, numericality: {less_than_or_equal_to: 10, greater_than_or_equal_to: 1}
  validates :skill_rate, presence: true, numericality: {less_than_or_equal_to: 10, greater_than_or_equal_to: 1}
  validates :voice_rate, presence: true, numericality: {less_than_or_equal_to: 10, greater_than_or_equal_to: 1}
  validates :earnest_rate, presence: true, numericality: {less_than_or_equal_to: 10, greater_than_or_equal_to: 1}
  validates :smile_rate, presence: true, numericality: {less_than_or_equal_to: 10, greater_than_or_equal_to: 1}
  validates :detail, length:{maximum:400}
end

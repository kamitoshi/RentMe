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

  # 一つのレビューに対して総合評価を出す
  def total_rates
    sum = self.service_rate + self.skill_rate + self.voice_rate + self.earnest_rate + self.smile_rate
    ave = sum.to_f / 5
    return ave.round(1)
  end

end

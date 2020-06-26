class Contract < ApplicationRecord
  belongs_to :worker
  belongs_to :employer

  enum status:{契約中: 0, レビュー待ち: 1, 契約終了: 2}

  validates :price, presence: true
  validates :target_date, presence: true
  validates :opening, presence: true
  validates :closing, presence: true
end

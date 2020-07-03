class Offer < ApplicationRecord
  belongs_to :suggest
  belongs_to :employer

  validates :price, presence: true
  validates :opening, presence: true
  validates :closing, presence: true

  def all_delete
    offers = self.suggest.offers
    offers.each do |o|
      if o == self
        next
      else
        o.destroy
      end
    end
  end

end

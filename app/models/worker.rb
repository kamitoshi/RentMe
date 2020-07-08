class Worker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum sex:{men: 0, women: 1, others: 2}
  enum prefecture: {
    北海道:1,
    青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
    沖縄県:47
  }

  has_many :suggests, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :contracts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :incumbents, dependent: :destroy
  has_many :banks, dependent: :destroy
  has_many :rooms, dependent: :nullify

  # Likeアソシエーション(現時点でワーカーからはlikeしない)
  has_many :likes, dependent: :destroy

  mount_uploader :image, WorkerUploader

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :kana_last_name, presence: true
  validates :kana_first_name, presence: true
  validates :sex, presence: true
  validates :phone_number, presence: true
  validates :postal_code, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :street, presence: true


  def address
    self.prefecture + self.city + self.street + self.building
  end

  def fullname
    self.last_name + "　" + self.first_name
  end

  def kana_fullname
    self.kana_last_name + "　" + self.kana_first_name
  end

  # 年齢を生年月日から算出
  def age
    (Date.today.strftime("%Y%m%d").to_i - self.birthday.strftime("%Y%m%d").to_i) / 10000
  end

  # 今掲載中の案件をだす
  def active_suggests
    self.suggests.where(is_active: true)
  end

  # 評価の平均値を出すため
  def service_rates
    rates = []
    self.reviews.each do |review|
      rates.push(review.service_rate)
    end
    average(rates).round(1)
  end

  def skill_rates
    rates = []
    self.reviews.each do |review|
      rates.push(review.skill_rate)
    end
    average(rates).round(1)
  end

  def voice_rates
    rates = []
    self.reviews.each do |review|
      rates.push(review.voice_rate)
    end
    average(rates).round(1)
  end

  def earnest_rates
    rates = []
    self.reviews.each do |review|
      rates.push(review.earnest_rate)
    end
    average(rates).round(1)
  end

  def smile_rates
    rates = []
    self.reviews.each do |review|
      rates.push(review.smile_rate)
    end
    average(rates).round(1)
  end

  def total_rates
    sum = service_rates + skill_rates + voice_rates + earnest_rates + smile_rates
    ave = sum.to_f / 5
    return ave.round(1)
  end

  # 評価の平均値を出す
  def average(array)
    sum = 0
    array.each do |num|
      sum += num
    end
    return ave = sum.to_f / array.length
  end

end

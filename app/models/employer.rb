class Employer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

  has_many :contracts, dependent: :nullify
  has_many :reviews, dependent: :nullify
  has_many :rooms, dependent: :nullify

  # offerを通してsuggestsを取り出す
  has_many :offers, dependent: :destroy
  has_many :offer_suggests, through: :offers, source: "suggest"

  # Holdアソシエーション 
  has_many :holds
  has_many :hold_suggests, through: :holds, source: "suggest"

  # Likeアソシエーション
  has_many :likes, dependent: :destroy
  has_many :like_workers, through: :workers, source: "worker"

  mount_uploader :image, EmployerUploader

  validates :store_name, presence: true
  validates :kana_store_name, presence: true
  validates :phone_number, presence: true
  validates :postal_code, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :street, presence: true

  def address
    self.prefecture + self.city + self.street + self.building
  end

  def holds?(suggest)
    hold = self.holds.find_by(suggest_id: suggest.id)
    if hold
      return true
    else
      return false
    end
  end

  # 既に引数のワーカーをお気に入り登録しているかを判別
  def liked?(worker)
    self.likes.find_by(worker_id: worker.id)
  end

  # 既に引数のSuggestに対してオファーしているか判別
  def offered?(suggest)
    self.offers.find_by(suggest_id: suggest.id)
  end

end

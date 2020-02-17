class Jukugo < ApplicationRecord

  # Callback
  after_save :create_jukugo_kanji

  # Association
  has_one   :jukugo_kanji, dependent: :destroy
  has_one   :kanji1, through: :jukugo_kanji
  has_one   :kanji2, through: :jukugo_kanji
  has_many  :quiz_wadokaichin_jukugo

  # Validation
  validates :name, presence: true, length: { maximum: 2 },
            uniqueness: { case_sensitive: true }

end

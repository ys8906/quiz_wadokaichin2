class Jukugo < ApplicationRecord

  # Association
  has_one   :jukugo_kanji, dependent: :destroy
  has_one   :kanji1, through: :jukugo_kanji
  has_one   :kanji2, through: :jukugo_kanji
  has_many  :quiz_wadokaichin_jukugo

  # Validation
  validates :name, presence: true, length: { maximum: 2 },
            uniqueness: { case_sensitive: true }
            # case_sensitive is required for Rails6.1 (warned by rspec)

end

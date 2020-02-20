class Kanji < ApplicationRecord
  has_many  :jukugo_kanjis
  validates :character, presence: true, length: { maximum: 1 },
            uniqueness: { case_sensitive: true }
end

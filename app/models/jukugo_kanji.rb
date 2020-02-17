class JukugoKanji < ApplicationRecord
  belongs_to  :jukugo
  belongs_to  :kanji1, class_name: "Kanji"
  belongs_to  :kanji2, class_name: "Kanji"
  validates   :jukugo_id, presence: true
  # validates :kanji1_id, presence: true
  # validates :kanji2_id, presence: true
end

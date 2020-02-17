class QuizWadokaichinJukugo < ApplicationRecord
  # Association
  belongs_to :quiz_wadokaichin
  belongs_to :jukugo1, class_name: "Jukugo"
  belongs_to :jukugo2, class_name: "Jukugo"
  belongs_to :jukugo3, class_name: "Jukugo"
  belongs_to :jukugo4, class_name: "Jukugo"

  # Validation
  validates :quiz_wadokaichin_id, presence: true
  validates :jukugo1_id, presence: true
  validates :jukugo2_id, presence: true
  validates :jukugo3_id, presence: true
  validates :jukugo4_id, presence: true
end

class QuizWadokaichin < ApplicationRecord

  # Association
  has_one :quiz_wadokaichin_jukugo, dependent: :destroy
  has_one :jukugo1, through: :quiz_wadokaichin_jukugo
  has_one :jukugo2, through: :quiz_wadokaichin_jukugo
  has_one :jukugo3, through: :quiz_wadokaichin_jukugo
  has_one :jukugo4, through: :quiz_wadokaichin_jukugo

  # Validation
  validates :answer, presence: true

end

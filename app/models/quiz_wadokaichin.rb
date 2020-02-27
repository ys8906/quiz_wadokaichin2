class QuizWadokaichin < ApplicationRecord

  # Association
  has_one :quiz_wadokaichin_jukugo, dependent: :destroy
  has_one :jukugo_right, through: :quiz_wadokaichin_jukugo
  has_one :jukugo_bottom, through: :quiz_wadokaichin_jukugo
  has_one :jukugo_left, through: :quiz_wadokaichin_jukugo
  has_one :jukugo_top, through: :quiz_wadokaichin_jukugo

  # Validation
  validates :answer, presence: true

end

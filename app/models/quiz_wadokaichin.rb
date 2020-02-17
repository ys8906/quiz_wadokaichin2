class QuizWadokaichin < ApplicationRecord
  has_one :quiz_wadokaichin_jukugo
  has_one :jukugo1, through: :quiz_wadokaichin_jukugo
  has_one :jukugo2, through: :quiz_wadokaichin_jukugo
  has_one :jukugo3, through: :quiz_wadokaichin_jukugo
  has_one :jukugo4, through: :quiz_wadokaichin_jukugo
end

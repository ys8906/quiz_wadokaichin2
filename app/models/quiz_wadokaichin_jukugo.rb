class QuizWadokaichinJukugo < ApplicationRecord

  # Association
  belongs_to :quiz_wadokaichin
  belongs_to :jukugo_right, class_name: "Jukugo"
  belongs_to :jukugo_bottom, class_name: "Jukugo"
  belongs_to :jukugo_left, class_name: "Jukugo"
  belongs_to :jukugo_top, class_name: "Jukugo"

  # Validation
  validates :quiz_wadokaichin_id, presence: true
  validates :jukugo_right_id, presence: true
  validates :jukugo_bottom_id, presence: true
  validates :jukugo_left_id, presence: true
  validates :jukugo_top_id, presence: true
  
end

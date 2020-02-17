class QuizWadokaichinJukugo < ApplicationRecord
  belongs_to :quiz_wadokaichin
  belongs_to :jukugo1, class_name: "Jukugo"
  belongs_to :jukugo2, class_name: "Jukugo"
  belongs_to :jukugo3, class_name: "Jukugo"
  belongs_to :jukugo4, class_name: "Jukugo"
end

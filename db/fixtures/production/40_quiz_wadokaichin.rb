# frozen_string_literal: true

require 'csv'
file_path = 'db/fixtures/development/40_quiz_wadokaichin/40_quiz_wadokaichin.csv'

CSV.foreach(file_path, headers: true) do |row|
  QuizWadokaichin.seed_once do |q|
    q.id                      = row['id']
    q.answer                  = row['answer']
    q.image_url               = row['image_url']
    q.jukugo_right_name       = row['jukugo_right_name']
    q.jukugo_bottom_name      = row['jukugo_bottom_name']
    q.jukugo_left_name        = row['jukugo_left_name']
    q.jukugo_top_name         = row['jukugo_top_name']
    q.difficulty              = row['difficulty']
  end

  QuizWadokaichinJukugo.seed_once do |qj|
    qj.id                     = row['id']
    qj.quiz_wadokaichin_id    = row['id']
    qj.jukugo_right_id        = Jukugo.find_by(name: row['jukugo_right_name']).id
    qj.jukugo_bottom_id       = Jukugo.find_by(name: row['jukugo_bottom_name']).id
    qj.jukugo_left_id         = Jukugo.find_by(name: row['jukugo_left_name']).id
    qj.jukugo_top_id          = Jukugo.find_by(name: row['jukugo_top_name']).id
  end
end

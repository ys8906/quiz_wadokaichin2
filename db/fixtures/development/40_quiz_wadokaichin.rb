require 'csv'
file_path = "db/fixtures/development/40_quiz_wadokaichin/40_quiz_wadokaichin.csv"

CSV.foreach(file_path, headers: true) do |row|
  Jukugo.seed_once do |j|
    j.id                      = row['id']
    j.answer                  = row['answer']
    j.image_url               = row['image_url']
    j.jukugo_right_name       = row['jukugo_right_name']
    j.jukugo_bottom_name      = row['jukugo_bottom_name']
    j.jukugo_left_name        = row['jukugo_left_name']
    j.jukugo_top_name         = row['jukugo_top_name']
  end
end
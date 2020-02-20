require 'csv'
file_path = "db/fixtures/development/30_jukugo.csv"

CSV.foreach(file_path, headers: true) do |row|
  Jukugo.seed_once do |j|
    j.id              = row['id']
    j.name            = row['name']
    j.reading         = row['reading']
    j.meaning         = row['meaning']
  end
end

require 'csv'
file_path = "db/fixtures/development/30_jukugo.csv"

CSV.foreach(file_path, headers: true) do |row|
  Jukugo.seed_once do |u|
    u.id           = row['id']
    u.name         = row['name']
    u.reading      = row['reading']
    u.meaning      = row['meaning']
  end
end

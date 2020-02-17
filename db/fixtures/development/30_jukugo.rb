require 'csv'
file_path = "db/fixtures/development/30_jukugo.csv"

CSV.foreach(file_path, headers: true) do |row|
  Jukugo.seed_once do |j|
    j.id              = row['id']
    j.name            = row['name']
    j.reading         = row['reading']
    j.meaning         = row['meaning']
  end

  JukugoKanji.seed_once do |jk|
    jk.id             = row['id']
    jk.jukugo_id      = row['id']
    jk.kanji1_id      = Kanji.where(character: row['name']
                        .slice(0))[0]&.id   # &. :return nil if kanji not exist
    jk.kanji2_id      = Kanji.where(character: row['name']
                        .slice(1))[0]&.id
  end
end

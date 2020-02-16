CSV.foreach('db/fixtures/development/20_kanji.csv', headers: true) do |row|
  Kanji.seed_once do |u|
    u.id                = row['id']
    u.character         = row['character']
    u.jis               = row['jis']
    u.joyo              = row['joyo']
    u.kanken            = row['kanken']
    u.primary_school    = row['primary_school']
  end
end

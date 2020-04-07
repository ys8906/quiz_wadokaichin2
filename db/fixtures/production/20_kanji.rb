# frozen_string_literal: true

require 'csv'
file_path = 'db/fixtures/development/20_kanji.csv'

CSV.foreach(file_path, headers: true) do |row|
  Kanji.seed_once do |k|
    k.id                = row['id']
    k.character         = row['character']
    k.jis               = row['jis']
    k.joyo              = row['joyo']
    k.kanken            = row['kanken']
    k.primary_school    = row['primary_school']
  end
end

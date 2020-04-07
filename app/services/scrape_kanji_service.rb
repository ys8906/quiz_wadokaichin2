# frozen_string_literal: true

class ScrapeKanjiService
  require 'open-uri'
  require 'csv'

  def scrape_kanken
    # ScrapeKanjiService.new.scrape_kanken
    10.times do |i|
      url       = "https://kanjijoho.com/cat/kyu#{i + 1}.html"
      file_path = "app/services/kanji/kanken/kanken_level_#{i + 1}.csv"

      CSV.open(file_path, 'w') do |c|
        # sleep 0.9
        doc = Nokogiri::HTML.parse(open(url))
        c << %w[unicode character]
        doc.xpath("//div[@id='main2']/table[@class='kyuichiran']/tr/td").each do |node|
          character = node.xpath('a').inner_text
          c << ["U+#{character.ord.to_s(16)}", character]
        end
        p c
      end
    end
  end

  def merge_kanji
    # ScrapeKanjiService.new.merge_kanji
    # Merge all kanji csv files into one
    file_path_merged = 'db/fixtures/development/20_kanji.csv'
    CSV.open(file_path_merged, 'w') do |c|
      c << %w[character jis joyo kanken primary_school]
      # jis
      4.times.each do |i|
        file_path_jis = "app/services/kanji/jis/jis_level_#{i + 1}.csv"
        CSV.foreach(file_path_jis, headers: true) do |row|
          c << [row[1], i + 1, 0, 0, 0]
        end
      end
      # joyo
      file_path_joyo = 'app/services/kanji/joyo/joyo_kanji.csv'
      CSV.foreach(file_path_joyo, headers: true) do |row|
        c << [row[1], 0, 1, 0, 0]
      end
      # kanken
      10.times.each do |i|
        file_path_kanken = "app/services/kanji/kanken/kanken_level_#{i + 1}.csv"
        CSV.foreach(file_path_kanken, headers: true) do |row|
          c << [row[1], 0, 0, i + 1, 0]
        end
      end
      # primary_school
      6.times.each do |i|
        file_path_primary_school = "app/services/kanji/primary_school/primary_school_#{i + 1}.csv"
        CSV.foreach(file_path_primary_school, headers: true) do |row|
          c << [row[1], 0, 0, 0, i + 1]
        end
      end
    end

    # Group by character to remove duplications
    csv = CSV.table(file_path_merged)
    tables_by_char = csv.group_by(&:first)
    merged_table = tables_by_char.map do |(_, character), rows|
      jis = rows.map { |r| r[:jis] }.max
      joyo = rows.map { |r| r[:joyo] }.max
      kanken = rows.map { |r| r[:kanken] }.max
      primary_school = rows.map { |r| r[:primary_school] }.max
      [character, jis, joyo, kanken, primary_school]
    end

    # Rewrite csv
    CSV.open(file_path_merged, 'w') do |c|
      csv << %w[id character jis joyo kanken primary_school]
      merged_table.each_with_index do |table, i|
        table.prepend(i + 1) # Insert kanji.id
        c.puts table
      end
    end
  end
end

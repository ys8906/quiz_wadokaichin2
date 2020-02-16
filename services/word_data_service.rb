class WordDataService

  require 'open-uri'
  require 'csv'

  def initialize
  end

  class << self

    def scrape_kanken         # WordDataService.scrape_kanken
      10.times do |i|
        url = "https://kanjijoho.com/cat/kyu#{i+1}.html"
  
        CSV.open("services/kanji/kanken/kanken_level_#{i+1}.csv", "w") do |csv|
          doc = Nokogiri::HTML.parse(open(url))
          csv << ["unicode", "character"]
          doc.xpath("//div[@id='main2']/table[@class='kyuichiran']/tr/td").each do |node|
            character = node.xpath("a").inner_text
            csv << ["U+#{character.ord.to_s(16)}", character]
          end
          p csv
        end
      end
    end
  
    def merge_kanji         # WordDataService.merge_kanji
      # Merge all kanji csv files into one
      CSV.open("db/fixtures/development/20_kanji.csv", "w") do |csv|
        csv << ["character", "jis", "joyo", "kanken", "primary_school"]
        # jis
        4.times.each do |i|
          CSV.foreach("services/kanji/jis/jis_level_#{i+1}.csv", headers: true) do |row|
            csv << [row[1], i+1, 0, 0, 0]
          end
        end
        # joyo
        CSV.foreach("services/kanji/joyo/joyo_kanji.csv", headers: true) do |row|
          csv << [row[1], 0, 1, 0, 0]
        end
        # kanken
        10.times.each do |i|
          CSV.foreach("services/kanji/kanken/kanken_level_#{i+1}.csv", headers: true) do |row|
            csv << [row[1], 0, 0, i+1, 0]
          end
        end
        # primary_school
        6.times.each do |i|
          CSV.foreach("services/kanji/primary_school/primary_school_#{i+1}.csv", headers: true) do |row|
            csv << [row[1], 0, 0, 0, i+1]
          end
        end
      end

      # Group by character to remove duplications
      csv = CSV.table("db/fixtures/development/20_kanji.csv")
      tables_by_char = csv.group_by(&:first)
      merged_table = tables_by_char.map do | (_, character), rows |
        jis = rows.map { |r| r[:jis] }.max
        joyo = rows.map { |r| r[:joyo] }.max
        kanken = rows.map { |r| r[:kanken] }.max
        primary_school = rows.map { |r| r[:primary_school ] }.max
        [character, jis, joyo, kanken, primary_school]
      end

      # Rewrite csv
      CSV.open("db/fixtures/development/20_kanji.csv", "w") do |csv|
        csv << ["id", "character", "jis", "joyo", "kanken", "primary_school"]
        merged_table.each_with_index do |table, i|
          table.prepend(i+1)      # Insert kanji.id
          csv.puts table
        end
      end
    end

    def scrape_jukugo                   # WordDataService.scrape_jukugo
      gyo = ["a", "k", "s", "t", "n",
              "h", "m", "y", "r", "w",
              "g", "z", "d", "b"]       # 行(子音)
      gyo.count.times do |g|
        CSV.open("services/jukugo/jukugo_#{gyo[g]}.csv", "w") do |csv|
          csv << ["id", "idiom", "reading", "meaning"]
          retu = 0                      # 段(母音): aiueo
          5.times do |r|                # [aiueo].length = 5
            retu += 1
            no = 0                      # each idiom page number
            skip_count = 0            
            4213.times do               # idioms starting from "し" count most (4213)
              break if skip_count > 30  # skip if empty pages count 30
              no += 1
              url = "https://k2.hofurink.com/products/myphp8.php?&gyo=#{gyo[g]}&retu=#{retu}&no=#{no}"
              doc = Nokogiri::HTML.parse(open(url))
              doc.xpath("//div[@id='Categories']/div/div[1]/table/tbody").each do |node|
                idiom = node.xpath("tr[1]/td/h3").inner_text.strip
                if idiom == ""
                  skip_count += 1
                  p "skipped #{skip_count} times"
                  next
                end
                reading = node.xpath("tr[2]/td/h3").inner_text.strip
                meaning = node.xpath("tr[4]/td/h3").inner_text.strip
                csv << [idiom, reading, meaning]
                p [idiom, reading, meaning]
              end
            end
          end
        end
      end
    end
    
  end
end


# url = "https://k2.hofurink.com/products/myphp8.php?&gyo=#{x}&retu=#{y}&no=#{z}"
# doc = Nokogiri::HTML.parse(open(url))
# doc.xpath("//div[@id='Categories']/div/div[1]/table/tbody").each do |node|
#   idiom = node.xpath("tr[1]/td/h3").text.strip
#   reading = node.xpath("tr[2]/td/h3").text.strip
#   meaning = node.xpath("tr[4]/td/h3").text.strip
#   p idiom
#   p reading
#   p meaning
# end
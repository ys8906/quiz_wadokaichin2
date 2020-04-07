# frozen_string_literal: true

class ScrapeJukugoService
  require 'open-uri'
  require 'csv'

  ## 熟語スクレイピング
  # scrape_jukugo: 全熟語データをスクレイピング
  # scrape_jukugo_example: 各熟語データの用例数を追加
  # merge_jukugo: 子音ごとに分かれた各熟語データをseed用ファイルに統合
  def scrape_jukugo
    # ScrapeJukugoService.new.scrape_jukugo
    gyo = %w[a k s t n
             h m y r w
             g z d b] # 行(子音)
    gyo.count.times do |g|
      file_path_each = "app/services/jukugo/jukugo_#{gyo[g]}.csv"
      CSV.open(file_path_each, 'w') do |c|
        c << %w[name reading meaning]
        retu = 0 # 段(母音): aiueo
        5.times do |_r| # [aiueo].length = 5
          retu += 1
          no = 0                      # each idiom page number
          skip_count = 0
          4213.times do               # idioms starting from "し" count most (4213)
            if skip_count > 30
              # other letter has less idioms, and it should break if contents end.
              break
            end

            # but some numbers are missing, and just a skip does not mean the end.
            # then, regard 30-time-skip as a guide of no more idioms for the letter
            no += 1
            url = "https://k2.hofurink.com/products/myphp8.php?&gyo=#{gyo[g]}&retu=#{retu}&no=#{no}"
            # sleep 0.9
            doc = Nokogiri::HTML.parse(open(url))
            doc.xpath("//div[@id='Categories']/div/div[1]/table/tbody").each do |node|
              idiom = node.xpath('tr[1]/td/h3').inner_text.strip
              if idiom == ''
                skip_count += 1
                p "skipped #{skip_count} times"
                next
              end
              reading = node.xpath('tr[2]/td/h3').inner_text.strip
              meaning = node.xpath('tr[4]/td/h3').inner_text.strip

              url_example = CGI.escape("http://yourei.jp/#{idiom}")
              doc = Nokogiri::HTML.parse(open(url_example))
              example = doc.xpath("//span[@id='num-examples']").inner_text.delete(',').to_i

              c << [idiom, reading, meaning, example]
              p [idiom, reading, meaning, example]
            end
          end
        end
      end
    end
  end

  def scrape_jukugo_examples
    # ScrapeJukugoService.new.scrape_jukugo_examples
    gyo = %w[a k s t n
             h m y r w
             g z d b] # 行(子音)
    gyo.count.times do |g|
      file_path_each = "app/services/jukugo/jukugo_#{gyo[g]}.csv"
      data = CSV.read(file_path_each)
      CSV.open(file_path_each, 'w') do |c|
        c << %w[name reading meaning example]
        data.each do |row|
          # sleep 0.9
          url_example = CGI.escape("http://yourei.jp/#{row[0]}")
          doc = Nokogiri::HTML.parse(open(url_example))
          example = doc.xpath("//span[@id='num-examples']").inner_text.delete(',').to_i
          c << [row[0], row[1], row[2], example]
          p [row[0], example]
        end
      end
    end
  end

  def merge_jukugo
    # ScrapeJukugoService.new.merge_jukugo
    gyo = %w[a k s t n
             h m y r w
             g z d b] # 行(子音)
    i = 0
    file_path_merged = 'db/fixtures/development/30_jukugo.csv'
    CSV.open(file_path_merged, 'w') do |c|
      c << %w[id name reading meaning example]
      gyo.count.times do |g|
        file_path_each = "app/services/jukugo/jukugo_#{gyo[g]}.csv"
        CSV.foreach(file_path_each, headers: true) do |row|
          i += 1
          c << [i, row[0], row[1], row[2], row[3]]
        end
      end
    end
  end
end

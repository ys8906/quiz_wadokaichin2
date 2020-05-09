# frozen_string_literal: true

class ScrapeYojijukugoService
  require 'open-uri'
  require 'csv'

  def scrape_yojijukugo
    # ScrapeYojijukugoService.new.scrape_yojijukugo
    require 'nkf'
    hiragana = ("ｱ".."ﾜ").to_a.map{ |chr| NKF.nkf("-h1w", NKF.nkf("-Xw", chr)) }
    file_path = "app/services/yojijukugo/yojijukugo.csv"
    CSV.open(file_path, 'w') do |c|
      c << ["yojijukugo", "reading", "link"]
      hiragana.each do |h|
        url = "https://www.kanjipedia.jp/sakuin/yojijyukugo/#{CGI.escape(h)}"
        doc = Nokogiri::HTML.parse(open(url))
        doc.xpath("//ul[@id='yojiJyukugoResultList']/li").each do |node|
          yojijukugo = node.xpath("a").inner_text.strip.slice(0..3)
          reading = node.xpath("a").xpath("span").inner_text
          link = "https://www.kanjipedia.jp/" + node.xpath("a").attribute("href")
          c << [yojijukugo, reading, link]
        end        
      end
    end
  end
end

# frozen_string_literal: true

class ScrapePeopleNameService
  require 'open-uri'
  require 'csv'

  def scrape_people_name
    # ScrapePeopleNameService.new.scrape_people_name
    file_path = "app/services/people_name/people_name.csv"
    CSV.open(file_path, 'w') do |c|
      c << ["category", "name", "reading"]
      50.times.each_with_index do |x, i|
        url = "http://www.kanji-jiten.jp/namelist/index#{i+1}.html"
        doc = Nokogiri::HTML.parse(open(url))
        doc.xpath("//div[@id='main']").each do |node|
          category = node.xpath("h1").inner_text
          names = node.css(".namaeyomi")
          names.each do |name|
            n = name.inner_text.split(/\//)
            if n[0].gsub(" ", "").length == 4
              c << [category, n[0].gsub(" ", ""), n[1].strip]
            end
          end
        end        
      end
    end
  end
end

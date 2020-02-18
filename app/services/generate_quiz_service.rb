class GenerateQuizService
  require 'open-uri'
  require 'uri'

  def initialize
  end

  class << self

    # TODO: need to prevent overlapping quiz (though unlikely to happen)
    # OPTIMIZE
    # FIXME

    ## Below is: generate_image method separate from generate_wadokaichin
    # def generate_image(right, down, left, up) # GenerateQuizService.generate_image
    #   url = URI.escape("https://res.cloudinary.com/dlab9jkaw/image/upload/" +
    #                     "l_text:Verdana_50_bold:#{right},g_east,x_160/" +
    #                     "l_text:Verdana_50_bold:#{down},g_south,y_35/" +
    #                     "l_text:Verdana_50_bold:#{left},g_west,x_160/" +
    #                     "l_text:Verdana_50_bold:#{up},g_north,y_35/" +
    #                     "wadokaichin_cwtzdu.jpg")
    #   file_path = "app/assets/quiz_wadokaichin/quiz_1.jpg"
    #   open(url) do |file|
    #     open(file_path, "wb") do |image|
    #       image.write(file.read)
    #     end
    #   end
    # end

    def generate_wadokaichin(kanji)         # GenerateQuizService.generate_wadokaichin()
      loop do
        # Take 2 jukugos from matched lists
        jukugo_left_match = Jukugo.where("name like ?", "#{kanji}%").sample(2)
        jukugo_right_match = Jukugo.where("name like ?", "%#{kanji}").sample(2)
        # If there are 2 (or more) kanjis, confirm before creating
        if jukugo_left_match.count == 2 && jukugo_right_match.count == 2
          p [kanji, jukugo_left_match[0].name, jukugo_left_match[1].name,
              jukugo_right_match[0].name, jukugo_right_match[1].name]
          p "これで作成しますか？[y/n]"
          response = gets
          case response
          # If yes, create and save quiz
          when /^[yY]/
            # Create QuizWadokaichin
            QuizWadokaichin.create(answer: kanji,
                                    jukugo_right_name: jukugo_left_match[0].name,
                                    jukugo_down_name: jukugo_left_match[1].name,
                                    jukugo_left_name: jukugo_right_match[0].name,
                                    jukugo_up_name: jukugo_right_match[1].name)
            # Create QuizWadokaichinJukugo (junction table)
            QuizWadokaichin.last.build_quiz_wadokaichin_jukugo\
              .update(jukugo_right_id: jukugo_left_match[0].id, jukugo_down_id: jukugo_left_match[1].id,
                      jukugo_left_id: jukugo_right_match[0].id, jukugo_up_id: jukugo_right_match[1].id)
            # Generate quiz_image
            image_url = URI.escape("https://res.cloudinary.com/dlab9jkaw/image/upload/" +
                  "l_text:Verdana_50_bold:#{QuizWadokaichin.last.jukugo_right_name.slice(1)},g_east,x_160/" +
                  "l_text:Verdana_50_bold:#{QuizWadokaichin.last.jukugo_down_name.slice(1)},g_south,y_35/" +
                  "l_text:Verdana_50_bold:#{QuizWadokaichin.last.jukugo_left_name.slice(0)},g_west,x_160/" +
                  "l_text:Verdana_50_bold:#{QuizWadokaichin.last.jukugo_up_name.slice(0)},g_north,y_35/" +
                  "wadokaichin_cwtzdu.jpg")
            image_file_path = "app/assets/quiz_wadokaichin/quiz_#{QuizWadokaichin.last.id}.jpg"
            open(image_url) do |file|
              open(image_file_path, "wb") do |image|
                image.write(file.read)
              end
            end
            return p "作成成功:
                      #{[kanji, jukugo_left_match[0].name, jukugo_left_match[1].name,
                        jukugo_right_match[0].name, jukugo_right_match[1].name]}"
          # If not, you can try again to pick up another pattern
          when /^[nN]/, /^$/
            p "作り直しますか？[y/n]"
            response = gets
            case response
            when /^[yY]/
              p "再生成"
              redo
            # If not, break the loop
            when /^[nN]/, /^$/
              p "n/a"
              return
            end
          end
        # If there are no more than 2 kanjis, break the loop
        else
          p "n/a"
        end
      end
    end

    def generate_wadokaichin_random         # GenerateQuizService.generate_wadokaichin_random
      loop do
        # Take random kanji from db
        kanji = Kanji.where('id >= ?', rand(Kanji.first.id..Kanji.last.id)).first
        # Take 2 jukugos from matched lists
        jukugo_left_match = Jukugo.where("name like ?", "#{kanji.character}%").sample(2)
        jukugo_right_match = Jukugo.where("name like ?", "%#{kanji.character}").sample(2)
        if jukugo_left_match.count == 2 && jukugo_right_match.count == 2
          p [kanji.character, jukugo_left_match[0].name, jukugo_left_match[1].name,
              jukugo_right_match[0].name, jukugo_right_match[1].name]
          p "これで作成しますか？[y/n]"
          response = gets
          case response
          # If yes, create and save quiz
          when /^[yY]/
            # Create QuizWadokaichin
            QuizWadokaichin.create(answer: kanji.character,
                                    jukugo_right_name: jukugo_left_match[0].name,
                                    jukugo_down_name: jukugo_left_match[1].name,
                                    jukugo_left_name: jukugo_right_match[0].name,
                                    jukugo_up_name: jukugo_right_match[1].name)
            # Create QuizWadokaichinJukugo (junction table)
            QuizWadokaichin.last.build_quiz_wadokaichin_jukugo\
              .update(jukugo_right_id: jukugo_left_match[0].id, jukugo_down_id: jukugo_left_match[1].id,
                      jukugo_left_id: jukugo_right_match[0].id, jukugo_up_id: jukugo_right_match[1].id)
            # Generate quiz_image
            image_url = URI.escape("https://res.cloudinary.com/dlab9jkaw/image/upload/" +
                  "l_text:Verdana_50_bold:#{QuizWadokaichin.last.jukugo_right_name.slice(1)},g_east,x_160/" +
                  "l_text:Verdana_50_bold:#{QuizWadokaichin.last.jukugo_down_name.slice(1)},g_south,y_35/" +
                  "l_text:Verdana_50_bold:#{QuizWadokaichin.last.jukugo_left_name.slice(0)},g_west,x_160/" +
                  "l_text:Verdana_50_bold:#{QuizWadokaichin.last.jukugo_up_name.slice(0)},g_north,y_35/" +
                  "wadokaichin_cwtzdu.jpg")
            image_file_path = "app/assets/quiz_wadokaichin/quiz_#{QuizWadokaichin.last.id}.jpg"
            open(image_url) do |file|
              open(image_file_path, "wb") do |image|
                image.write(file.read)
              end
            end
            return p "作成成功: #{[kanji.character,
                      jukugo_left_match[0].name, jukugo_left_match[1].name,
                      jukugo_right_match[0].name, jukugo_right_match[1].name]}"
          # If not, you can try again to pick up another pattern
          when /^[nN]/, /^$/
            p "作り直しますか？[y/n]"
            response = gets
            case response
            when /^[yY]/
              p "再生成"
              redo
            # If not, break the loop
            when /^[nN]/, /^$/
              p "n/a"
              return
            end
          end
        end
      end
    end

  end
end
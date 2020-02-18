class GenerateQuizService

  def initialize
  end

  class << self

    # TODO: need to prevent overlapping quiz (though unlikely to happen)
    # OPTIMIZE
    # FIXME

    def generate_wadokaichin(kanji)         # GenerateQuizService.generate_wadokaichin()
      loop do
        jukugo_left_match = Jukugo.where("name like ?", "#{kanji}%").sample(2)
        jukugo_right_match = Jukugo.where("name like ?", "%#{kanji}").sample(2)
        if jukugo_left_match.count == 2 && jukugo_right_match.count == 2
          p [kanji, jukugo_left_match[0].name, jukugo_left_match[1].name,
              jukugo_right_match[0].name, jukugo_right_match[1].name]
          p "これで作成しますか？[y/n]"
          response = gets
          case response
          when /^[yY]/
            QuizWadokaichin.create(answer: kanji,
                                    jukugo_right_name: jukugo_left_match[0].name,
                                    jukugo_down_name: jukugo_left_match[1].name,
                                    jukugo_left_name: jukugo_right_match[0].name,
                                    jukugo_up_name: jukugo_right_match[1].name)
            QuizWadokaichin.last.build_quiz_wadokaichin_jukugo\
              .update(jukugo_right_id: jukugo_left_match[0].id, jukugo_down_id: jukugo_left_match[1].id,
                      jukugo_left_id: jukugo_right_match[0].id, jukugo_up_id: jukugo_right_match[1].id)
            return p "作成成功:
                      #{[kanji, jukugo_left_match[0].name, jukugo_left_match[1].name,
                        jukugo_right_match[0].name, jukugo_right_match[1].name]}"
          when /^[nN]/, /^$/
            p "作り直しますか？[y/n]"
            response = gets
            case response
            when /^[yY]/
              p "再生成"
              redo
            when /^[nN]/, /^$/
              p "n/a"
              return
            end
          end
        else
          p "n/a"
        end
      end
    end

    def generate_wadokaichin_random         # GenerateQuizService.generate_wadokaichin_random
      loop do
        kanji = Kanji.where('id >= ?', rand(Kanji.first.id..Kanji.last.id)).first
        jukugo_left_match = Jukugo.where("name like ?", "#{kanji.character}%").sample(2)
        jukugo_right_match = Jukugo.where("name like ?", "%#{kanji.character}").sample(2)
        if jukugo_left_match.count == 2 && jukugo_right_match.count == 2
          p [kanji.character, jukugo_left_match[0].name, jukugo_left_match[1].name,
              jukugo_right_match[0].name, jukugo_right_match[1].name]
          p "これで作成しますか？[y/n]"
          response = gets
          case response
          when /^[yY]/
            QuizWadokaichin.create(answer: kanji.character,
                                    jukugo_right_name: jukugo_left_match[0].name,
                                    jukugo_down_name: jukugo_left_match[1].name,
                                    jukugo_left_name: jukugo_right_match[0].name,
                                    jukugo_up_name: jukugo_right_match[1].name)
            QuizWadokaichin.last.build_quiz_wadokaichin_jukugo\
              .update(jukugo_right_id: jukugo_left_match[0].id, jukugo_down_id: jukugo_left_match[1].id,
                      jukugo_left_id: jukugo_right_match[0].id, jukugo_up_id: jukugo_right_match[1].id)
            return p "作成成功: #{[kanji.character,
                      jukugo_left_match[0].name, jukugo_left_match[1].name,
                      jukugo_right_match[0].name, jukugo_right_match[1].name]}"
          when /^[nN]/, /^$/
            p "作り直しますか？[y/n]"
            response = gets
            case response
            when /^[yY]/
              p "再生成"
              redo
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
class GenerateQuizService

  def initialize
  end

  class << self

    # TODO: need to prevent overlapping quiz (though unlikely to happen)
    # OPTIMIZE
    # FIXME

    def generate_wadokaichin(kanji)         # GenerateQuizService.generate_wadokaichin()
      loop do
        jukugo_left = Jukugo.where("name like ?", "#{kanji}%").sample(2)
        jukugo_right = Jukugo.where("name like ?", "%#{kanji}").sample(2)
        if jukugo_left.count == 2 && jukugo_right.count == 2
          p [kanji, jukugo_left[0].name, jukugo_left[1].name, jukugo_right[1].name]
          p "これで作成しますか？[y/n]"
          response = gets
          case response
          when /^[yY]/
            QuizWadokaichin.create(answer: kanji,
                                    jukugo1_name: jukugo_left[0].name,
                                    jukugo2_name: jukugo_left[1].name,
                                    jukugo3_name: jukugo_right[0].name,
                                    jukugo4_name: jukugo_right[1].name)
            QuizWadokaichin.last.build_quiz_wadokaichin_jukugo\
              .update(jukugo1_id: jukugo_left[0].id, jukugo2_id: jukugo_left[1].id,
                      jukugo3_id: jukugo_right[0].id, jukugo4_id: jukugo_right[1].id)
            return p "作成成功: #{[kanji, jukugo_left[0].name, jukugo_left[1].name, jukugo_right[1].name]}"
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
        jukugo_left = Jukugo.where("name like ?", "#{kanji.character}%").sample(2)
        jukugo_right = Jukugo.where("name like ?", "%#{kanji.character}").sample(2)
        if jukugo_left.count == 2 && jukugo_right.count == 2
          p [kanji.character, jukugo_left[0].name, jukugo_left[1].name, jukugo_right[1].name]
          p "これで作成しますか？[y/n]"
          response = gets
          case response
          when /^[yY]/
            QuizWadokaichin.create(answer: kanji.character,
                                    jukugo1_name: jukugo_left[0].name,
                                    jukugo2_name: jukugo_left[1].name,
                                    jukugo3_name: jukugo_right[0].name,
                                    jukugo4_name: jukugo_right[1].name)
            QuizWadokaichin.last.build_quiz_wadokaichin_jukugo\
              .update(jukugo1_id: jukugo_left[0].id, jukugo2_id: jukugo_left[1].id,
                      jukugo3_id: jukugo_right[0].id, jukugo4_id: jukugo_right[1].id)
            return p "作成成功: #{[kanji.character, jukugo_left[0].name, jukugo_left[1].name, jukugo_right[1].name]}"
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
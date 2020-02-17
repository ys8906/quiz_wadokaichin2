class GenerateQuizService

  def initialize
  end

  class << self

    # TODO: need to prevent quiz from overlapping (though unlikely to happen)

    def generate_wadokaichin(kanji)         # GenerateQuizService.generate_wadokaichin()
      jukugo_left = Jukugo.where("name like ?", "#{kanji}%").sample(2)
      jukugo_right = Jukugo.where("name like ?", "%#{kanji}").sample(2)
      if jukugo_left.count == 2 && jukugo_right.count == 2
        QuizWadokaichin.create(answer: kanji,
                                jukugo1_name: jukugo_left[0].name,
                                jukugo2_name: jukugo_left[1].name,
                                jukugo3_name: jukugo_right[0].name,
                                jukugo4_name: jukugo_right[1].name)
        QuizWadokaichin.last.build_quiz_wadokaichin_jukugo\   # line-break
          .update(jukugo1_id: jukugo_left[0].id, jukugo2_id: jukugo_left[1].id,
                  jukugo3_id: jukugo_right[0].id, jukugo4_id: jukugo_right[1].id)
      else
        p "n/a"
      end
    end

    def generate_wadokaichin_random         # GenerateQuizService.generate_wadokaichin_random
      loop do
        kanji = Kanji.where('id >= ?', rand(Kanji.first.id..Kanji.last.id)).first
        jukugo_left = Jukugo.where("name like ?", "#{kanji.character}%").sample(2)
        jukugo_right = Jukugo.where("name like ?", "%#{kanji.character}").sample(2)
        if jukugo_left.count == 2 && jukugo_right.count == 2
          QuizWadokaichin.create(answer: kanji,
                                  jukugo1_name: jukugo_left[0].name,
                                  jukugo2_name: jukugo_left[1].name,
                                  jukugo3_name: jukugo_right[0].name,
                                  jukugo4_name: jukugo_right[1].name)
          QuizWadokaichin.last.build_quiz_wadokaichin_jukugo\
            .update(jukugo1_id: jukugo_left[0].id, jukugo2_id: jukugo_left[1].id,
                    jukugo3_id: jukugo_right[0].id, jukugo4_id: jukugo_right[1].id)
          return
        end
      end
    end

  end
end
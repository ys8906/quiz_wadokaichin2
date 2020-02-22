class GenerateQuizService

  # TODO: 重複を防ぐメソッド（確率が低いので後回し）

  ## 共通メソッド
  def kanji_has_jukugos?(left_size, right_size)
    true if (left_size + right_size == 4)
  end

  def create_quiz_wadokaichin(kanji, jukugo_left_match, jukugo_right_match)
    # QuizWadokaichinを生成
    quiz = QuizWadokaichin.create(answer: kanji, jukugo_right_name: jukugo_left_match.first.name,
                                                 jukugo_bottom_name: jukugo_left_match.last.name,
                                                 jukugo_left_name: jukugo_right_match.first.name,
                                                 jukugo_top_name: jukugo_right_match.last.name)
    # QuizWadokaichinJukugo（中間テーブル）を生成
    quiz.create_quiz_wadokaichin_jukugo(jukugo_right_id: jukugo_left_match.first.id,
                                        jukugo_bottom_id: jukugo_left_match.last.id,
                                        jukugo_left_id: jukugo_right_match.first.id,
                                        jukugo_top_id: jukugo_right_match.last.id)
  end

  ## 個別メソッド
  def generate_wadokaichin_random_auto         # GenerateQuizService.new.generate_wadokaichin_random_auto
    loop do
      kanji = Kanji.offset(rand(Kanji.count)).first.character
      jukugo_left_match = Jukugo.where("name like ?", "#{kanji}%").sample(2)
      jukugo_right_match = Jukugo.where("name like ?", "%#{kanji}").sample(2)
      if kanji_has_jukugos?(jukugo_left_match.size, jukugo_right_match.size)
        create_quiz_wadokaichin(kanji, jukugo_left_match, jukugo_right_match)
        return QuizWadokaichin.last
      end
    end
  end

  def generate_wadokaichin_random         # GenerateQuizService.new.generate_wadokaichin_random
    loop do
      # DBから漢字をランダムに取ってくる
      kanji = Kanji.offset(rand(Kanji.count)).first.character
      # DBから左右に対象の漢字を含む熟語を二つ持ってくる
      jukugo_left_match = Jukugo.where("name like ?", "#{kanji}%").sample(2)
      jukugo_right_match = Jukugo.where("name like ?", "%#{kanji}").sample(2)
      if kanji_has_jukugos?(jukugo_left_match.size, jukugo_right_match.size)
        p [kanji, jukugo_left_match.first.name, jukugo_left_match.last.name,
            jukugo_right_match.first.name, jukugo_right_match.last.name]
        p "これで作成しますか？[y/n]"
        response = gets
        case response
        # yesならクイズを生成
        when /^[yY]/
          create_quiz_wadokaichin(kanji, jukugo_left_match, jukugo_right_match)
          return QuizWadokaichin.last
        # 該当する熟語がない場合、別の漢字でやり直せる
        when /^[nN]/, /^$/
          p "作り直しますか？[y/n]"
          response = gets
          case response
          when /^[yY]/
            p "再生成"
            redo
          # やり直さない場合、ループを終了する
          when /^[nN]/, /^$/
            p "n/a"
            return
          end
        end
      end
    end
  end

    def generate_wadokaichin(kanji)         # GenerateQuizService.new.generate_wadokaichin()
    loop do
      # DBから左右に対象の漢字を含む熟語を二つ持ってくる
      jukugo_left_match = Jukugo.where("name like ?", "#{kanji}%").sample(2)
      jukugo_right_match = Jukugo.where("name like ?", "%#{kanji}").sample(2)
      # 当てはまる熟語が2つ以上存在する場合、生成を続けるか確認する
      if kanji_has_jukugos?(jukugo_left_match.size, jukugo_right_match.size)
        p [kanji, jukugo_left_match.first.name, jukugo_left_match.last.name,
            jukugo_right_match.first.name, jukugo_right_match.last.name]
        p "これで作成しますか？[y/n]"
        response = gets
        case response
        # yesならクイズを生成
        when /^[yY]/
          create_quiz_wadokaichin(kanji, jukugo_left_match, jukugo_right_match)
          return QuizWadokaichin.last
        # 該当する熟語がない場合、別の漢字でやり直せる
        when /^[nN]/, /^$/
          p "作り直しますか？[y/n]"
          response = gets
          case response
          when /^[yY]/
            p "再生成"
            redo
          # やり直さない場合、ループを終了する
          when /^[nN]/, /^$/
            p "n/a"
            return
          end
        end
      # 該当する熟語がない場合、ループを終了する
      else
        p "n/a"
      end
    end
  end

end
# frozen_string_literal: true

class GenerateQuizService
  ### QuizWadokaichin
  ## 共通メソッド
  # validation
  def combination_is_valid?(jukugo_left_match, jukugo_right_match)
    condition = kanji_has_jukugos?(jukugo_left_match, jukugo_right_match) &&
                quiz_is_unique?(jukugo_left_match, jukugo_right_match)
    condition ? true : false
  end

  def kanji_has_jukugos?(jukugo_left_match, jukugo_right_match)
    jukugo_left_match.size + jukugo_right_match.size == 4
  end

  def quiz_is_unique?(jukugo_left_match, jukugo_right_match)
    QuizWadokaichin.all.each do |quiz|
      if (([quiz.jukugo_left, quiz.jukugo_bottom] - jukugo_left_match) +
          ([quiz.jukugo_right, quiz.jukugo_top] - jukugo_right_match)) == []
        return false
      end
    end
    true
  end

  # QuizWadokaichinを生成
  def create_quiz_wadokaichin(kanji, jukugo_left_match, jukugo_right_match)
    # 難易度: Σ(1/各熟語の用例数) * 100,000を四捨五入した数
    difficulty = (((1.to_f / jukugo_left_match.first.example)   +
                   (1.to_f / jukugo_left_match.last.example)    +
                   (1.to_f / jukugo_right_match.first.example)  +
                   (1.to_f / jukugo_right_match.last.example)) * 100_000).round

    quiz = QuizWadokaichin.create(answer: kanji, jukugo_right_name: jukugo_left_match.first.name,
                                  jukugo_bottom_name: jukugo_left_match.last.name,
                                  jukugo_left_name: jukugo_right_match.first.name,
                                  jukugo_top_name: jukugo_right_match.last.name,
                                  difficulty: difficulty)
    # QuizWadokaichinJukugo（中間テーブル）を生成
    quiz.create_quiz_wadokaichin_jukugo(jukugo_right_id: jukugo_left_match.first.id,
                                        jukugo_bottom_id: jukugo_left_match.last.id,
                                        jukugo_left_id: jukugo_right_match.first.id,
                                        jukugo_top_id: jukugo_right_match.last.id)
  end

  ## 自動作成メソッド
  def generate_wadokaichin_random_auto # GenerateQuizService.new.generate_wadokaichin_random_auto
    loop do
      kanji = Kanji.offset(rand(Kanji.count)).first.character
      # cf. 熟語数 -> 全熟語：47462、用例1以上: 37548、用例100以上: 23490、用例1000以上: 9902
      jukugo_left_match = Jukugo.where('name like ?', "#{kanji}%")
                                .where(example: 1000..Float::INFINITY).sample(2)
      jukugo_right_match = Jukugo.where('name like ?', "%#{kanji}")
                                 .where(example: 1000..Float::INFINITY).sample(2)
      if combination_is_valid?(jukugo_left_match, jukugo_right_match)
        create_quiz_wadokaichin(kanji, jukugo_left_match, jukugo_right_match)
        return QuizWadokaichin.last
      end
    end
  end
end

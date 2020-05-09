# frozen_string_literal: true

class GenerateQuizService
  ## 共通メソッド
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
  def generate_wadokaichin_random_auto
    # GenerateQuizService.new.generate_wadokaichin_random_auto
    loop do
      kanji = Kanji.offset(rand(Kanji.count)).first.character
      # left/right_match: 共通する漢字が左(右)側でマッチする
      # 　(例)出: left -> 出口, right -> 算出
      # cf. 熟語数 -> 全熟語：47462、用例1以上: 37548、用例100以上: 23490、用例1000以上: 9902
      jukugo_left_match  = Jukugo.where('name like ?', "#{kanji}%")
                                 .where(example: 1000..Float::INFINITY).sample(2)
      jukugo_right_match = Jukugo.where('name like ?', "%#{kanji}")
                                 .where(example: 1000..Float::INFINITY).sample(2)
      if combination_is_valid?(jukugo_left_match, jukugo_right_match)
        create_quiz_wadokaichin(kanji, jukugo_left_match, jukugo_right_match)
        return QuizWadokaichin.last
      end
    end
  end

  ## 逆引き検索
  def search_from_jukugos(first, second, third, fourth)
    # GenerateQuizService.new.search_from_jukugos()
    # 特定の4文字について、(反)時計周りで順番が違わないように、漢字・熟語を検索
    # 可能なのは以下の4*2通り
    # 　縦軸: t: top, r: right, b: bottom, l: left
    # 　横軸: L: left_match, R: right_match
    #           時計回り 反時計回り
    #     LLRR  rblt    brtl
    #     LRRL  bltr    rtlb
    #     RLLR  trbl    lbrt
    #     RRLL  ltrb    tlbr
    # firstから順に、上のパターンに合うような熟語を絞っていき、和銅開珍を完成させる
    # 　(例)出: 出口(L)　出演(L)　検出(R)　算出(R)

    search_first_left_matches(first, second, third, fourth)
    search_first_right_matches(first, second, third, fourth)
    if (@LLRRs + @LRRLs + @RLLRs + @RRLLs).blank?
      p "該当する組み合わせはありませんでした。"
    else
      p "以下の組み合わせが見つかりました。"
      puts "@LLRRs: #{@LLRRs}" if @LLRRs.present?
      puts "@LRRLs: #{@LRRLs}" if @LRRLs.present?
      puts "@RLLRs: #{@RLLRs}" if @RLLRs.present?
      puts "@RRLLs: #{@RRLLs}" if @RRLLs.present?
    end
  end

  def create_from_yojijukugos
    # GenerateQuizService.new.create_from_yojijukugos
    file_path = "app/services/yojijukugo/yojijukugo.csv"
    file_path_judged = "app/services/yojijukugo/yojijukugo_judged.csv"
    CSV.open(file_path_judged, 'w') do |c|
      c << ["kanji", "first", "second", "third", "fourth"]
      CSV.foreach(file_path, headers: true) do |row|
        p row[0]
        first   = row[0].slice(0)
        second  = row[0].slice(1)
        third   = row[0].slice(2)
        fourth  = row[0].slice(3)
        search_first_left_matches(first, second, third, fourth)
        search_first_right_matches(first, second, third, fourth)
        c << @LLRRs if @LLRRs.present?
        c << @LRRLs if @LRRLs.present?
        c << @RLLRs if @RLLRs.present?
        c << @RRLLs if @RRLLs.present?
      end
    end
  end

  def search_first_left_matches(first, second, third, fourth)
    jukugo_first_left_matches  = Jukugo.where('name like ?', "%#{first}")
    lls = []
    lrs = []
    jukugo_first_left_matches.each do |j|
      kanji = j.name.slice(0)
      l2 = kanji + second
      lls << [kanji, j.name, l2] if Jukugo.find_by(name: l2)
      r2 = second + kanji
      lrs << [kanji, j.name, r2] if Jukugo.find_by(name: r2)
    end

    @LLRRs = []
    lls.each do |ll|
      r3 = third + ll[0]
      if Jukugo.find_by(name: r3)
        r4 = fourth + ll[0]
        @LLRRs << [ll, r3, r4].flatten if Jukugo.find_by(name: r4)
      end
    end

    @LRRLs = []
    lrs.each do |lr|
      r3 = third + lr[0]
      if Jukugo.find_by(name: r3)
        l4 = lr[0] + fourth
        @LRRLs << [lr, r3, l4].flatten if Jukugo.find_by(name: l4)
      end
    end
  end

  def search_first_right_matches(first, second, third, fourth)
    jukugo_first_right_matches  = Jukugo.where('name like ?', "#{first}%")
    rls = []
    rrs = []
    jukugo_first_right_matches.each do |j|
      kanji = j.name.slice(1)
      l2 = kanji + second
      rls << [kanji, j.name, l2] if Jukugo.find_by(name: l2)
      r2 = second + kanji
      rrs << [kanji, j.name, r2] if Jukugo.find_by(name: r2)
    end

    @RLLRs = []
    rls.each do |rl|
      l3 = rl[0] + third
      if Jukugo.find_by(name: l3)
        r4 = fourth + rl[0]
        @RLLRs << [rl, l3, r4].flatten if Jukugo.find_by(name: r4)
      end
    end

    @RRLLs = []
    rrs.each do |rr|
      l3 = rr[0] + third
      if Jukugo.find_by(name: l3)
        l4 = rr[0] + fourth
        @RRLLs << [rr, l3, l4].flatten if Jukugo.find_by(name: l4)
      end
    end
  end
end

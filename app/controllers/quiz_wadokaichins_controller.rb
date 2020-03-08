class QuizWadokaichinsController < ApplicationController
  add_breadcrumb "ホーム", :root_path
  def index
    params[:order] ? (order = params[:order]) : (order = "created_at DESC")
    if params[:unanswered].to_i.zero? && params[:answered].to_i.zero? && params[:answer_shown].to_i.zero?
      @quizzes = QuizWadokaichin.order(order).page(params[:page]).per(9)
    else
      # OPTIMIZE: これ以上きれいに書けるやつおるん？
      # 複数回使うため、ユーザーのセーブデータを変数にしておく
      savedata = current_user.quiz_wadokaichin_savedata
      # セーブデータの各状態(status)をもとに式を展開
      statuses =["answer_shown", "answer_shown"]    ### ステータスが増えるようなら、enum(erize)を導入する
      searched_ids = statuses.each_with_object([]) do |status, a|
        # もし状態にチェックがあれば（params[:status] == "1"）、該当するクイズidを代入
          # fetchを使って、変数をparamsのキーと対応させる
        a << savedata.where(correct: status).pluck(:id) if params.fetch(status) == "1"
      end
      # 最後に、未回答のクイズ（params[:unanswered]）にチェックがあれば、データのないクイズidを代入する
      searched_ids << QuizWadokaichin.pluck(:id) - savedata.pluck(:id) if params[:unanswered] == "1"
      # 条件に当てはまるidの配列を使い、@quizzesを生成
      @quizzes = QuizWadokaichin.order(order).where(id: searched_ids.flatten).page(params[:page]).per(9)
    end
  end

  def show
    @quiz               = QuizWadokaichin.find(params[:id])
    @title              = "No." + @quiz.id.to_s
    @reactions          = @quiz.quiz_wadokaichin_reactions
    @savedata           = current_user&.quiz_wadokaichin_savedata&.where(quiz_wadokaichin_id: @quiz.id)
    @related_quizzes    = QuizWadokaichin.order("RAND()").limit(9)
    add_breadcrumb "和銅開珍 No.#{@quiz.id}", quiz_wadokaichin_path
  end
end

class QuizWadokaichinsController < ApplicationController
  def index
    params[:order] ? (order = params[:order]) : (order = "created_at DESC")
    @quizzes = QuizWadokaichin.order(order).page(params[:page]).per(9)
  end

  def show
    @quiz       = QuizWadokaichin.find(params[:id])
    @url        = request.url
    @reactions  = @quiz.quiz_wadokaichin_reactions
    @remote_ip  = request.remote_ip
    @savedata   = current_user&.quiz_wadokaichin_savedata&.where(quiz_wadokaichin_id: @quiz.id)
    @related_quizzes    = QuizWadokaichin.page(params[:page]).per(6)
  end
end

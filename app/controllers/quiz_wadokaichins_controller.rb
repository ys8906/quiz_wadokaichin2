class QuizWadokaichinsController < ApplicationController
  def show
    @quiz       = QuizWadokaichin.find(params[:id])
    @url        = request.url
    @reactions  = @quiz.quiz_wadokaichin_reactions
    @remote_ip  = request.remote_ip
    @savedata   = current_user&.quiz_wadokaichin_savedata&.where(quiz_wadokaichin_id: @quiz.id)
    @related_quizzes    = QuizWadokaichin.page(params[:page]).per(6)
  end
end

class QuizWadokaichinsController < ApplicationController
  def show
    @quiz = QuizWadokaichin.find(params[:id])
    @reactions = @quiz.quiz_wadokaichin_reactions
    @remote_ip = request.remote_ip
  end
end

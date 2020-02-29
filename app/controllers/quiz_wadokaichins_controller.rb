class QuizWadokaichinsController < ApplicationController
  def show
    @quiz = QuizWadokaichin.find(params[:id])
    @url = request.url
  end
end

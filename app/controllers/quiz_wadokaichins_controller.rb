class QuizWadokaichinsController < ApplicationController
  def show
    @quiz = QuizWadokaichin.find(params[:id])
  end
end

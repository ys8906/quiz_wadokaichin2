class QuizWadokaichinsController < ApplicationController
  def show
    @quiz = QuizWadokaichin.find(params[:id])
    @answer = params[:answer]

    if @answer == ""
      flash[:info] = ""
    elsif @answer == @quiz.answer
      flash.now[:info] = "Correct!"
    else
      flash.now[:info] = "Incorrect!"
    end
  end
end

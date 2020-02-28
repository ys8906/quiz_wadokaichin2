class QuizWadokaichinsController < ApplicationController

  def index
    if params[:category]
      @quizzes = params[:category].constantize.all
                  .order(order = params[:order]).page(params[:page]).per(9)
    else
      @quizzes = QuizWadokaichin.all.order("created_at DESC").page(params[:page]).per(9)
    end
  end

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

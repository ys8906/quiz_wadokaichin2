class HomeController < ApplicationController
  def root
    if params[:category]
      @quizzes = params[:category].constantize.all
                  .order(order = params[:order]).page(params[:page]).per(9)
    else
      @quizzes = QuizWadokaichin.all.order("created_at DESC").page(params[:page]).per(9)
    end
  end
end

class UserPagesController < ApplicationController
  add_breadcrumb "ホーム", :root_path
  before_action :authenticate_user!

  def index
    params[:page]   ? (page = params[:page])    : (page = 1)
    params[:order]  ? (@order = params[:order])  : (@order = "id DESC")
    if @order.include?("updated_at ASC") || @order.include?("updated_at DESC")
      ids = current_user.quiz_wadokaichin_savedata.
        where(correct: params[:page]).order(@order).pluck(:quiz_wadokaichin_id)
      @quizzes = QuizWadokaichin.where(id: ids)
    else
      ids = current_user.quiz_wadokaichin_savedata.
        where(correct: params[:page]).pluck(:quiz_wadokaichin_id)
      @quizzes = QuizWadokaichin.where(id: ids).order(@order)
    end

    @savedata = current_user.quiz_wadokaichin_savedata
    add_breadcrumb "クイズ履歴", user_pages_path
  end
end

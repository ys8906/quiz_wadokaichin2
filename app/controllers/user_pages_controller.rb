# frozen_string_literal: true

class UserPagesController < ApplicationController
  add_breadcrumb '> ホーム', :root_path
  before_action :authenticate_user!

  def index
    page = params[:page] || 1
    params[:order] ? (@order = params[:order]) : (@order = 'id DESC')
    ids = current_user.
          quiz_wadokaichin_savedata
          .where(correct: page).pluck(:quiz_wadokaichin_id)
    @quizzes = QuizWadokaichin.where(id: ids).order(@order)

    @savedata = current_user.quiz_wadokaichin_savedata
    add_breadcrumb 'クイズ履歴', user_pages_path
  end
end

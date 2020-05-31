# frozen_string_literal: true

class Api::V1::QuizWadokaichinSavedataController < ApplicationController
  def create
    if !current_user.quiz_wadokaichin_savedata.find_by(quiz_wadokaichin_id: params[:quiz_id])
      current_user.quiz_wadokaichin_savedata.create(
        quiz_wadokaichin_id: params[:quiz_id],
        correct: params[:correct]
      )
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def create_params
    params.require(:quiz_wadokaichin_savedata).permit(:quiz_id, :correct)
  end
end

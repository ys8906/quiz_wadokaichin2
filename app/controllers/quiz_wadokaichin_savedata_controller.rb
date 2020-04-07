# frozen_string_literal: true

class QuizWadokaichinSavedataController < ApplicationController
  def create
    current_user.quiz_wadokaichin_savedata
                .create!(quiz_wadokaichin_id: params[:quiz_id], correct: params[:correct])
    redirect_back(fallback_location: root_path)
  end

  private

  def create_params
    params.require(:quiz_wadokaichin_savedata).permit(:quiz_id, :correct)
  end
end

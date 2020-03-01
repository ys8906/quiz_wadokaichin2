class QuizWadokaichinReactionsController < ApplicationController
  def create
    QuizWadokaichin.find(params[:quiz_id]).quiz_wadokaichin_reactions.
                    create(remote_ip: params[:remote_ip], rating: params[:rating])
    flash[:info] = "投票しました！"
    redirect_back(fallback_location: root_path)
  end
end

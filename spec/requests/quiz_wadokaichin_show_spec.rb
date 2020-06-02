# frozen_string_literal: true

require "rails_helper"

RSpec.describe "QuizWadokaichin#show", type: :request do
  include_context "header_footer_examples"
  subject { get quiz_wadokaichin_path(QuizWadokaichin.second.id); response }

  it_behaves_like "ヘッダーとフッターに適切な表示がされる"

  before do
    # create_listだとデータが全て同じ: uniquenessに引っかかる
    4.times { create(:quiz_wadokaichin) }
  end

  it "クイズID・クイズレベル・前後のクイズへのリンクが表示される" do
    expect(subject.body).to include QuizWadokaichin.second.id.to_s
    expect(subject.body).to include QuizWadokaichin.second.difficulty.to_s
    expect(subject.body).to include QuizWadokaichin.first.id.to_s
    expect(subject.body).to include QuizWadokaichin.third.id.to_s
  end

  it "関連クイズが表示される" do
    expect(subject.body).to include QuizWadokaichin.fourth.image_url
    expect(subject.body).to include QuizWadokaichin.fourth.id.to_s
    expect(subject.body).to include QuizWadokaichin.fourth.difficulty.to_s
    expect(subject.body).to include QuizWadokaichin.fourth.created_at.strftime('%Y/%m/%d')
  end

  ## Vueなのでrequestではテストできない
  # it "クイズ画像・回答欄・解答するボタン・答えを見るボタンが表示される" do
  #   expect(subject.body).to include QuizWadokaichin.second.image_url
  #   expect(subject.body).to include "解答は1文字です"
  #   expect(subject.body).to include "解答する"
  #   expect(subject.body).to include "答えを見る"
  # end

  # it "いいね・ツイートボタンが表示される" do
  #   expect(subject.body).to include "いいね"
  #   expect(subject.body).to include "Tweet"
  # end  

  # context "ログインしていない、またはクイズ履歴のないユーザーは、" do
  #   it "「以前回答した問題です」と表示されない" do
  #     expect(subject.body).to_not include "以前回答した問題です"
  #   end
  # end

  # context "ログイン済みで、クイズ履歴のあるユーザーは、" do
  #   it "「以前回答した問題です」と表示される" do
  #     sign_in user
  #     user.quiz_wadokaichin_savedata << build(
  #       :quiz_wadokaichin_savedatum,
  #       quiz_wadokaichin_id: QuizWadokaichin.second.id
  #     )
  #     expect(subject.body).to include "以前回答した問題です"
  #   end
  # end
end
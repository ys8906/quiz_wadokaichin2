# frozen_string_literal: true

require "rails_helper"

RSpec.describe "QuizWadokaichin#index", type: :request do
  include_context "header_footer_examples"
  subject { get root_path; response }

  it_behaves_like "ヘッダーとフッターに適切な表示がされる"

  before do
    # create_listだとデータが全て同じ: uniquenessに引っかかる
    11.times { create(:quiz_wadokaichin) }
  end

  it "クイズが表示される" do
    expect(subject.body).to include QuizWadokaichin.last.image_url
    expect(subject.body).to include QuizWadokaichin.last.id.to_s
    expect(subject.body).to include QuizWadokaichin.last.difficulty.to_s
    expect(subject.body).to include QuizWadokaichin.last.created_at.strftime('%Y/%m/%d')
  end

  it "ページネーションが表示される" do
    expect(subject.body).to include "pagination"
  end

  it "ツイッターのタイムラインが表示される" do
    expect(subject.body).to include "twitter-timeline"
  end

  context "ログインしていないユーザーは、" do
    it "答えを見た・正解した・未回答のクイズのチェックボックスが表示されない" do
      expect(subject.body).to_not include "答えを見たクイズ"
      expect(subject.body).to_not include "正解したクイズ"
      expect(subject.body).to_not include "未回答のクイズ"
    end
  end

  context "ログインしているユーザーは、" do
    before { sign_in user }
    it "答えを見た・正解した・未回答のクイズのチェックボックスが表示される" do
      expect(subject.body).to include "答えを見たクイズ"
      expect(subject.body).to include "正解したクイズ"
      expect(subject.body).to include "未回答のクイズ"
    end
  end
end
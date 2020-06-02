# frozen_string_literal: true

require "rails_helper"

RSpec.describe "UserPagesController", type: :request do
  subject { get user_pages_path; response }
  let(:user) { create(:user) }

  context "ログインしていないユーザーは、" do
    it "ログイン画面にリダイレクトされる" do
      expect(subject).to redirect_to root_path
    end
  end

  context "ログインしているユーザーは、" do
    context "正解または答えを見たクイズがない場合は、" do
      before { sign_in user }
      it "正解したクイズが表示されない" do
        expect(subject.body).to include "該当するクイズはありません"
      end
      it "答えを見たクイズが表示されない" do
        get user_pages_path, params: { page: 0 }
        expect(response.body).to include "該当するクイズはありません"
      end
    end
    context "正解または答えを見たクイズがある場合は、" do
      let(:user_with_quiz_records) { create(:user, :with_quiz_records) }
      before { sign_in user_with_quiz_records }
      it "正解したクイズが表示される" do
        expect(subject.body).to include
          user_with_quiz_records.quiz_wadokaichin_savedata.first.quiz_wadokaichin_id
      end
      it "答えを見たクイズが表示される" do
        get user_pages_path, params: { page: 0 }
        expect(response.body).to include
          user_with_quiz_records.quiz_wadokaichin_savedata.second.quiz_wadokaichin_id
      end
    end
  end
end
# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::QuizWadokaichinSavedata", type: :request do
  subject {
    post api_v1_quiz_wadokaichin_savedata_path,
    params: {
      quiz_id: 1,
      correct: 1
    }
  }
  let(:user) { create(:user) }
  let(:user_with_quiz_records) { create(:user, :with_quiz_records) }

  context "クイズ履歴がない場合は、" do
    before { sign_in user }
    it "履歴を作成する" do
      expect {
        post api_v1_quiz_wadokaichin_savedata_path,
        params: {
          quiz_id: 1,
          correct: 1
        }
      }.to change(user.quiz_wadokaichin_savedata, :count).by(1)
    end
  end

  context "クイズ履歴がある場合は、履歴を作成しない" do
    before { sign_in user_with_quiz_records }
    it "履歴を作成する" do
      expect {
        post api_v1_quiz_wadokaichin_savedata_path,
        params: {
          quiz_id: user_with_quiz_records.
                    quiz_wadokaichin_savedata.
                    first.
                    quiz_wadokaichin_id,
          correct: 1
        }
      }.to_not change(user_with_quiz_records.quiz_wadokaichin_savedata, :count)
    end
  end
end
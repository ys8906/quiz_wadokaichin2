shared_context "header_footer_examples" do
  # インスタンス
  let(:user) { create(:user) }

  # テスト
  shared_examples "ヘッダーとフッターに適切な表示がされる" do
    context "ログインしていないユーザーは、" do
      it "ログインボタンが表示される" do
        expect(subject.body).to include "ログイン"
      end
      it "ログアウトボタンが表示されない" do
        expect(subject.body).to_not include "ログアウト"
      end
    end
    context "ログインしているユーザーは、" do
      before { sign_in user }
      it "クイズ履歴リンク・ユーザー情報変更リンク・ログアウトボタンが表示される" do
        expect(subject.body).to include "クイズ履歴"
        expect(subject.body).to include "ユーザー情報変更"
        expect(subject.body).to include "ログアウト"
      end
      it "ログインボタンが表示されない" do
        expect(subject.body).to_not include "ログイン"
      end
    end
  end
end
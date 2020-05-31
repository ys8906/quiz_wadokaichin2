# frozen_string_literal: true

require "rails_helper"

RSpec.describe "UserSessions", type: :request do
  include_context "omniauth_users"

  context "ログインしているユーザーは、" do
    before { sign_in user }
    it "/users/sign_up にアクセスできない" do
      get new_user_registration_path
      expect(response).to redirect_to root_path
    end
  
    it "/users/sign_in にアクセスできない" do
      get new_user_session_path
      expect(response).to redirect_to root_path
    end
  end  

  context "ログインしていないユーザーは、" do
    it "/users/sign_up にアクセスできる" do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  
    it "/users/sign_in にアクセスできる" do
      get new_user_session_path
      expect(response).to have_http_status(:success)
    end

    context "メールアドレスで、" do
      it "アカウント登録ができる" do
        expect {
          post user_registration_path,
          params: {
            user: {
              name: "name" ,
              email: "email@test.com",
              password: "password"}
            }
        }.to change(User,:count).by(1)
        expect(response.status).to eq 302
        expect(User.find_by(name: "name")).to be_valid
        expect(ActionMailer::Base.deliveries.last.subject).to include("ようこそクイズ和銅開珎へ！")
      end
  
      it "ログインできる" do
        post user_session_path,
          params: {
            user: {
              email: user.email,
              password: user.password,
              password_confirmation: user.password
            }
          }
        expect(response.status).to eq 302
      end
    end

    context "ツイッターアカウントが、" do
      before { Rails.application.env_config['omniauth.auth'] = twitter_user }
      subject { post user_twitter_omniauth_callback_path }
      context "未登録の場合、" do
        context "emailがあれば、" do
          let(:omniauth_email) { "koreha@email.desuka?" }
          it "得られた情報でアカウントを作成する" do
            expect { subject }.to change { User.count }.by(1)
            expect(ActionMailer::Base.deliveries.last.subject).to include("ようこそクイズ和銅開珎へ！")
          end
        end
        context "emailがなければ" do
          let(:omniauth_email) { nil }
          it "ダミーアドレスでアカウントを作成する" do
            expect { subject }.to change { User.count }.by(1)
            expect(ActionMailer::Base.deliveries.last.subject).to include("ようこそクイズ和銅開珎へ！")
          end
        end
      end
      context "登録済みの場合、" do
        let(:omniauth_email) { "email@test.com" }
        it "アカウントを作成せず、ログインする" do
          create(:user, email: "email@test.com")
          expect { subject }.to_not change { User.count }
          expect(response).to redirect_to root_path
        end
      end
    end

    context "Googleアカウントが、" do
      before { Rails.application.env_config['omniauth.auth'] = google_user }
      subject { post user_google_oauth2_omniauth_callback_path }
      context "未登録の場合、" do
        context "emailがあれば、" do
          let(:omniauth_email) { "koreha@email.desuka?" }
          it "得られた情報でアカウントを作成する" do
            expect { subject }.to change { User.count }.by(1)
            expect(ActionMailer::Base.deliveries.last.subject).to include("ようこそクイズ和銅開珎へ！")
          end
        end
        context "emailがなければ" do
          let(:omniauth_email) { nil }
          it "ダミーアドレスでアカウントを作成する" do
            expect { subject }.to change { User.count }.by(1)
            expect(ActionMailer::Base.deliveries.last.subject).to include("ようこそクイズ和銅開珎へ！")
          end
        end
      end
      context "登録済みの場合、" do
        let(:omniauth_email) { "email@test.com" }
        it "アカウントを作成せず、ログインする" do
          create(:user, email: "email@test.com")
          expect { subject }.to_not change { User.count }
          expect(response).to redirect_to root_path
        end
      end
    end

    context "Yahooアカウントが、" do
      before { Rails.application.env_config['omniauth.auth'] = yahoo_user }
      subject { post user_yahoojp_omniauth_callback_path }
      context "未登録の場合、" do
        context "emailがあれば、" do
          let(:omniauth_email) { "koreha@email.desuka?" }
          it "得られた情報でアカウントを作成する" do
            expect { subject }.to change { User.count }.by(1)
            expect(ActionMailer::Base.deliveries.last.subject).to include("ようこそクイズ和銅開珎へ！")
          end
        end
        context "emailがなければ" do
          let(:omniauth_email) { nil }
          it "ダミーアドレスでアカウントを作成する" do
            expect { subject }.to change { User.count }.by(1)
            expect(ActionMailer::Base.deliveries.last.subject).to include("ようこそクイズ和銅開珎へ！")
          end
        end
      end
      context "登録済みの場合、" do
        let(:omniauth_email) { "email@test.com" }
        it "アカウントを作成せず、ログインする" do
          create(:user, email: "email@test.com")
          expect { subject }.to_not change { User.count }
          expect(response).to redirect_to root_path
        end
      end
    end

    context "Lineアカウントが、" do
      before { Rails.application.env_config['omniauth.auth'] = line_user }
      subject { post user_line_omniauth_callback_path }
      context "未登録の場合、" do
        context "emailがあれば、" do
          let(:omniauth_email) { "koreha@email.desuka?" }
          it "得られた情報でアカウントを作成する" do
            expect { subject }.to change { User.count }.by(1)
            expect(ActionMailer::Base.deliveries.last.subject).to include("ようこそクイズ和銅開珎へ！")
          end
        end
        context "emailがなければ" do
          let(:omniauth_email) { nil }
          it "ダミーアドレスでアカウントを作成する" do
            expect { subject }.to change { User.count }.by(1)
            expect(ActionMailer::Base.deliveries.last.subject).to include("ようこそクイズ和銅開珎へ！")
          end
        end
      end
      context "登録済みの場合、" do
        let(:omniauth_email) { "email@test.com" }
        it "アカウントを作成せず、ログインする" do
          create(:user, email: "email@test.com")
          expect { subject }.to_not change { User.count }
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
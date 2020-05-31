shared_context "omniauth_users" do
  let(:user) { create(:user) }

  let(:twitter_user) {
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      "provider" => "twitter",
      "uid" => "123456",
      "info" => {
        "name" => "name",
        "email" => omniauth_email,
      },
      "credentials" => {
        "token" => "token",
        "secret" => "secret"
      }
    })
  }

  let(:google_user) {
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      "provider" => "google_oauth2",
      "uid" => "123456",
      "info" => {
        "name" => "name",
        "email" => omniauth_email,
      },
      "credentials" => {
        "token" => "token",
        "secret" => "secret"
      }
    })
  }

  let(:yahoo_user) {
    OmniAuth.config.mock_auth[:yahoojp] = OmniAuth::AuthHash.new({
      "provider" => "yahoojp",
      "uid" => "123456",
      "info" => {
        "name" => "name",
        "email" => omniauth_email,
      },
      "credentials" => {
        "token" => "token",
        "secret" => "secret"
      }
    })
  }

  let(:line_user) {
    OmniAuth.config.mock_auth[:line] = OmniAuth::AuthHash.new({
      "provider" => "line",
      "uid" => "123456",
      "info" => {
        "name" => "name",
        "email" => omniauth_email,
      },
      "credentials" => {
        "token" => "token",
        "secret" => "secret"
      }
    })
  }
end
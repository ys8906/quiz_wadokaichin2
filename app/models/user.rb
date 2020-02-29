class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  # Callbacks
  after_create :send_welcome_mail

  # Omniauth
  def self.from_omniauth(auth)
    if auth.provider == "twitter" || "line"
      user = User.where(uid: auth.uid, provider: auth.provider).first
      unless user
        user = User.create(
          provider: auth.provider,
          uid:      auth.uid,
          name:     auth.info.name,
          email:    User.dummy_email(auth),       # emailが得られない場合、こちらで用意
          password: Devise.friendly_token[0, 20]  # Deviseのパスワード生成機能
        )
      end
    elsif auth.provider == "google_oauth2"
      user = User.where(email: auth.info.email).first
      unless user
        user = User.create(
          provider: auth.provider,
          uid:      auth.uid,
          name:     auth.info.name,
          email:    auth.info.email,
          password: Devise.friendly_token[0, 20]
        )
      end
    elsif auth.provider == "yahoojp"
      user = User.where(email: auth.info.email).first
      unless user
        user = User.create(
          provider: auth.provider,
          uid:      auth.uid,
          name:     auth.info.name,
          email:    auth.info.email,
          password: Devise.friendly_token[0, 20]
        )
      end
    end
    user
  end

  def send_welcome_mail
    ApplicationMailer.user_welcome_mail(self).deliver
  end

  private
    # ユニークアドレスを生成
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@social-login.com"
    end

end

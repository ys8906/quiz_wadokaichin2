class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  # Callbacks
  after_create :send_welcome_mail

  # Omniauth-twitter
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
 
    unless user
      user = User.create(
        provider: auth.provider,
        uid:      auth.uid,
        name: auth.info.nickname,
        email:    User.dummy_email(auth),       # omniauth-twitterからはemailが得られないため、
                                                # ユニークアドレスをこちらで用意
        password: Devise.friendly_token[0, 20]  # Deviseのパスワード生成機能
      )
    end

    user
  end

  def send_welcome_mail
    ApplicationMailer.user_welcome_mail(self).deliver
  end

  private
    # omniauth-twitterからはemail情報が得られないが、deviseにはemailが必要
      # そのため、ユニークなアドレスをこちらで用意
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@social-login.com"
    end

end

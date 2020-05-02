# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  # Callbacks
  after_create :send_welcome_mail

  # Associations
  has_many :quiz_wadokaichin_savedata, dependent: :destroy

  # Omniauth
  def self.from_omniauth(auth)
    if auth.info.email.blank?
      user = User.where(uid: auth.uid, provider: auth.provider).first
      user ||= User.create(
        provider: auth.provider,
        uid: auth.uid,
        name: auth.info.name,
        email: User.dummy_email(auth), # emailが得られない場合、こちらで用意
        password: Devise.friendly_token[0, 20] # Deviseのパスワード生成機能
      )
    else
      user = User.where(email: auth.info.email).first
      user ||= User.create(
        provider: auth.provider,
        uid: auth.uid,
        name: auth.info.name,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  def send_welcome_mail
    UsersMailer.send_welcome_mail(self).deliver
  rescue StandardError
    # エラー報告
    @notifier = Slack::Notifier.new(Rails.application.credentials.slack[:webhook_url])
    @notifier.ping "#{Time.now}: [エラー] #{$ERROR_POSITION}"
  end

  # ユニークアドレスを生成
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@ys8906-social-login.com"
  end

end

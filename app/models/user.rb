# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)
#  uid                    :string(255)
#
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
  end

  # ユニークアドレスを生成
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@ys8906-social-login.com"
  end

end
